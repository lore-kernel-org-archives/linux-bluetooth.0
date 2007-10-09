Return-Path: <fabchevalier@free.fr>
Message-ID: <470BF392.9050409@free.fr>
Date: Tue, 09 Oct 2007 23:33:06 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>,
        Brad Midgley <bmidgley@xmission.com>,
        Johan Hedberg <johan.hedberg@nokia.com>, thiagossantos@gmail.com,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Concept implementation: (still to be named) newipc.h
Content-Type: multipart/mixed;
 boundary="------------020101070700010505040801"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------020101070700010505040801
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

All,

Please find attached a conceptual new API between the audio service and 
whatever audio framework we have (ALSA, GStreamer, PulseAudio, or 
whatever). :-)

This new API would be defined under LGPL, so that guys like me can use 
it for some in house closed source projects( Luiz, and Johan,
i hope that's OK with you :-) ).

The principles of the API are the following:
  - define a set of messages (that would be the functions in 
traditionnal C programming)
  - define a set of structs, *one per message* (that would be the
list of arguments in traditionnal C programming).
  - define a reduced set of a few helper functions to bootstrap the 
message exchange process, as well as to retrieve the data fd through 
ancilliary data.

The usage of the API should be relatively straightforward : you would 
use bz_audio_service_open() to retrieve the file descriptor, and then 
integrated it in your main loop or whatever.

Then you would read fixed size data chunks that you would cast to 
t_bz_audio_msg_header to retrieve the message type. Once you have the 
message type, you would cast again the result to a structure that 
matches the message name, and obtain the list of parameters that are 
relevant for this message.

I didn't want to bring more features in the API as otherwise we would 
start to implement toolkit-dependant behaviours (such as need a 
mainloop, or a need for GLIB, or ...)

I think this API is a lot easier to maintain in the long term that what 
we have today, where structure are shared between messages, and some 
messages have more that one data structure. :-)

If we can reach an agreement quite rapidly (that would mean today :-)), 
then i could start implementing it right away and hopefully have a 
mostly working implementation on sunday night.

As always, comments are welcomed !

Cheers,

Fabien


--------------020101070700010505040801
Content-Type: text/x-chdr;
 name="newipc.h"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="newipc.h"

/*
 *
 *  BlueZ - Bluetooth protocol stack for Linux
 *
 *  Copyright (C) 2004-2007  Marcel Holtmann <marcel@holtmann.org>
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 *
 */

/*
  Message sequence chart of streaming sequence for A2DP transport
  
  Audio daemon                       User
                             on snd_pcm_open
                 <--BZ_GETCAPABILITIES_REQ

  BZ_GETCAPABILITIES_RSP-->

                        on snd_pcm_hw_params
                <--BZ_SETCONFIGURATION_REQ

  BZ_SETCONFIGURATION_RSP-->

			on snd_pcm_prepare
                <--BZ_STREAMSTART_REQ

  <Moves to streaming state>
  BZ_STREAMSTART_RSP-->

  BZ_DATAFD_IND -->

                          <  streams data >
                             ..........

               on snd_pcm_drop/snd_pcm_drain

                <--BZ_STREAMSTOP_REQ

  <Moves to open state>
  BZ_STREAMSTOP_RSP-->
    
			on IPC close or appl crash 
  <Moves to idle>
			
 */

#ifndef NEWIPC_H

#include <stdint.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <errno.h>

#define BZ_AUDIO_IPC_MTU   128
#define BZ_IPC_SOCKET_NAME "\0/org/bluez/audio"

#ifndef UNIX_PATH_MAX
#define UNIX_PATH_MAX 108
#endif

/* Generic message header definition */
typedef struct {
	uint8_t msg_type;
} __attribute__ ((packed)) t_bz_audio_msg_header;

/* Messages list */
#define BZ_GETCAPABILITIES_REQ		0
#define BZ_GETCAPABILITIES_RSP		1

#define BZ_SETCONFIGURATION_REQ		2
#define BZ_SETCONFIGURATION_RSP		3

#define BZ_STREAMSTART_REQ		4
#define BZ_STREAMSTART_RSP		5

#define BZ_STREAMSTOP_REQ		6
#define BZ_STREAMSTOP_RSP		7

#define BZ_CONTROL_REQ			8
#define BZ_CONTROL_RSP			9
#define BZ_CONTROL_IND		       10

#define BZ_DATAFD_IND		       11

/* BZ_CAPABILITIES_REQ */

#define BZ_CAPABILITIES_REQ_TRANSPORT_A2DP	0
#define BZ_CAPABILITIES_REQ_TRANSPORT_SCO	1
#define BZ_CAPABILITIES_REQ_TRANSPORT_ANY	2

struct bz_capabilites_req {
	t_bz_audio_msg_header h;
 	uint8_t transport;
} __attribute__ ((packed));

/* BZ_CAPABILITIES_RSP */

/**
 * SBC Codec parameters as per A2DP profile 1.0 § 4.3
 */

#define BZ_A2DP_SAMPLING_FREQ_16000		(1 << 3)
#define BZ_A2DP_SAMPLING_FREQ_32000		(1 << 2)
#define BZ_A2DP_SAMPLING_FREQ_44100		(1 << 1)
#define BZ_A2DP_SAMPLING_FREQ_48000		1

#define BZ_A2DP_CHANNEL_MODE_MONO		(1 << 3)
#define BZ_A2DP_CHANNEL_MODE_DUAL_CHANNEL	(1 << 2)
#define BZ_A2DP_CHANNEL_MODE_STEREO		(1 << 1)
#define BZ_A2DP_CHANNEL_MODE_JOINT_STEREO	1

#define BZ_A2DP_BLOCK_LENGTH_4			(1 << 3)
#define BZ_A2DP_BLOCK_LENGTH_8			(1 << 2)
#define BZ_A2DP_BLOCK_LENGTH_12			(1 << 1)
#define BZ_A2DP_BLOCK_LENGTH_16			1

#define BZ_A2DP_SUBBANDS_4			(1 << 1)
#define BZ_A2DP_SUBBANDS_8			1

#define BZ_A2DP_ALLOCATION_SNR			(1 << 1)
#define BZ_A2DP_ALLOCATION_LOUDNESS		1

typedef struct {
	uint8_t channel_mode:4;
	uint8_t frequency:4;
	uint8_t allocation_method:2;
	uint8_t subbands:2;
	uint8_t block_length:4;
	uint8_t min_bitpool;
	uint8_t max_bitpool;
} __attribute__ ((packed)) t_SBC_capabilities ;

/* To be defined */
typedef struct {
} __attribute__ ((packed)) t_MPEG_capabilities;

struct bz_capabilites_rsp {
	t_bz_audio_msg_header	h;
	uint8_t			posix_errno;
	uint8_t			transport;          /* Selected transport */
	uint8_t			pkt_len;            /* Max length that transport supports */
	t_SBC_capabilities	sbc_capabilities;   /* A2DP only */
	t_MPEG_capabilities	mpeg_capabilities;  /* A2DP only */
	uint16_t		sampling_rate;	    /* SCO only */
} __attribute__ ((packed));

/* BZ_CONFIGURATION_REQ */
struct bz_configuration_req {
	t_bz_audio_msg_header	h;
	t_SBC_capabilities 	sbc_capabilities;   /* A2DP only - only one of this field
						   and next one must be filled */
	t_MPEG_capabilities	mpeg_capabilities;  /* A2DP only */
} __attribute__ ((packed));

/* BZ_CONFIGURATION_RSP */
struct bz_configuration_rsp {
	t_bz_audio_msg_header 	h;
	uint8_t 		posix_errno;
} __attribute__ ((packed));

/* BZ_STREAMSTART_REQ */
#define BZ_STREAM_ACCESS_READ		0
#define BZ_STREAM_ACCESS_WRITE		1
#define BZ_STREAM_ACCESS_READWRITE	2
struct bz_streamstart_req {
	t_bz_audio_msg_header 	h;
	uint8_t			stream_access;
} __attribute__ ((packed));

/* BZ_STREAMSTART_RSP */
struct bz_streamstart_rsp {
	t_bz_audio_msg_header 	h;
	uint8_t 		posix_errno;
} __attribute__ ((packed));

/* BZ_DATAFD_IND */
/* This message is followed by one byte of data containing the stream data fd
   as ancilliary data */
struct bz_datafd_ind {
	t_bz_audio_msg_header 	h;
} __attribute__ ((packed));


/* BZ_CONTROL_REQ */

#define BZ_CONTROL_KEY_POWER			0x40
#define BZ_CONTROL_KEY_VOL_UP			0x41
#define BZ_CONTROL_KEY_VOL_DOWN			0x42
#define BZ_CONTROL_KEY_MUTE			0x43
#define BZ_CONTROL_KEY_PLAY			0x44
#define BZ_CONTROL_KEY_STOP			0x45
#define BZ_CONTROL_KEY_PAUSE			0x46
#define BZ_CONTROL_KEY_RECORD			0x47
#define BZ_CONTROL_KEY_REWIND			0x48
#define BZ_CONTROL_KEY_FAST_FORWARD		0x49
#define BZ_CONTROL_KEY_EJECT			0x4A
#define BZ_CONTROL_KEY_FORWARD			0x4B
#define BZ_CONTROL_KEY_BACKWARD			0x4C

struct bz_control_req {
	t_bz_audio_msg_header 	h;
	uint8_t 		mode;		/* Control Mode */
	uint8_t 		key;		/* Control Key */
} __attribute__ ((packed));

/* BZ_CONTROL_RSP */
struct bz_volume_rsp {
	t_bz_audio_msg_header 	h;
	uint8_t 		posix_errno;
	uint8_t 		mode;		/* Control Mode */
	uint8_t 		key;		/* Control Key */
} __attribute__ ((packed));

/* BZ_CONTROL_IND */
struct bz_volume_ind {
	t_bz_audio_msg_header 	h;
	uint8_t 		mode;		/* Control Mode */
	uint8_t 		key;		/* Control Key */
} __attribute__ ((packed));

/* Function definitions */

static inline int bz_audio_service_open()
{
	int sk;
	int err;
	struct sockaddr_un addr = {
		AF_UNIX, "\0/org/bluez/audio"
	};

	sk = socket(PF_LOCAL, SOCK_STREAM, 0);
	if (sk < 0) {
		err = errno;
		fprintf(stderr, "%s: Cannot open socket: %s (%d)\n", __FUNCTION__, strerror(err), err);
		errno = err;
		return -1;
	}

	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
		err = errno;
		fprintf(stderr, "%s: Connection fail: %s (%d)\n", __FUNCTION__, strerror(err), err);
		close(sk);
		errno = err;
		return -1;
	}
}

static inline int bz_audio_service_close(int sk)
{
	return close(sk);
}

static inline int bz_audio_service_get_data_fd(int sk)
{
	char cmsg_b[CMSG_SPACE(sizeof(int))], m;
	int err, ret;
	struct iovec iov = { &m, sizeof(m) };
	struct msghdr msgh;
	struct cmsghdr *cmsg;

	memset(&msgh, 0, sizeof(msgh));
	msgh.msg_iov = &iov;
	msgh.msg_iovlen = 1;
	msgh.msg_control = &cmsg_b;
	msgh.msg_controllen = CMSG_LEN(sizeof(int));

	ret = recvmsg(sk, &msgh, 0);
	if (ret < 0) {
		err = errno;
		fprintf(stderr, "%s: Unable to receive fd: %s (%d)\n", __FUNCTION__, strerror(err), err);
		errno = err;
		return -1;
	}

	/* Receive auxiliary data in msgh */
	for (cmsg = CMSG_FIRSTHDR(&msgh); cmsg != NULL;
			cmsg = CMSG_NXTHDR(&msgh, cmsg)) {
		if (cmsg->cmsg_level == SOL_SOCKET
				&& cmsg->cmsg_type == SCM_RIGHTS) {
			return (*(int *) CMSG_DATA(cmsg));
		}
	}

	errno = EINVAL;
	return -1;
}

#endif /* NEWIPC_H */

--------------020101070700010505040801--
