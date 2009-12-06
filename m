Return-Path: <cyrus@holtmann.org>
Message-ID: <4B1BE6E3.4070000@gmail.com>
Date: Sun, 06 Dec 2009 18:16:19 +0100
From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: questions regarding pcm_bluetooth alsa plugin
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm trying really hard to write an alsa plugin that does something very much similar to the pcm_bluetooth plugin.
However, IMHO the alsa plugin programming SDK documentation is _extremely_ bad which makes plugin programming somehow hard.

My plugin should basically read and write audio PCM samples from/to a socket (which is what the bluez pcm_bluetooth plugin does as well).

For this reason I have a few questions regarding the pcm_bluetooth alsa plugin
(http://git.kernel.org/?p=bluetooth/bluez.git;a=blob;f=audio/pcm_bluetooth.c;h=13cf3ee20280714c1b9937d707890595c3b105d5;hb=HEAD)


* did you ever have problems with the start() callback function not being called ?

  I wrote some minimalistic example code (see below) that leads to the following output:

	$ aplay -D play test_8khz_16LE_mono.wav
	play_hw_constraint:140 26191 
	Playing WAVE 'test_8khz_16LE_mono.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
	snd_pcm_play_prepare:71 26191 hw_ptr -> 0
	snd_pcm_play_pointer:54 26191 ptr: 0
	snd_pcm_play_transfer:63 26191 aborting with -EINVAL ...
	aplay: pcm_write:1442: write error: Invalid argument

  As you can see, the start callback function is *never* called.


* is the start callback function *always* called when a stream is played back/recorded ?

  In my code example below the start callback is not called and I would really like to know why.


* do you know why in my example code below the start callback function is never called ?

  I would like to do the same as in the bluez pcm_bluetooth plugin code which is starting
  a playback_hw_thread from the start() callback function and then using it to time the data transfers
  to the socket.


* how does the polling code in pcm_bluetooth work, can you give a short description ?

  I saw that you are polling on 2 filedescriptors: one is the socket that the bluez plugin is writing to
  and the other one seems to be the pipe descriptor that is used to communicate with the playback_hw_thread.
  
  What does the alsa framework do if both polling criteria are met ? Call the transfer callback function ?
  


* what is is purpose of the playback_hw_thread ?

  It seems to me that the sole purpose of the playback_hw_thread is to update the hw_ptr.
  Each time it does that, it also writes a dummy byte "w" to the pipe-pair so that
  the alsa framework is "woken up" as it is polling on the pipe.

  I guess the purpose of all this is to "delay" the data transfer so that the period timing is correct, right ?
  Thus if one for example plays a previously recorded wave file through the bluez plugin, the mentioned code
  ensures that not all PCM samples in the wave file are immediately written to the socket, but instead they are written
  period-by-period with a certain amount of delay in between (which is calculated from the sampling rate).


* what is the purpose of the delay() callback function ?

  data->hw_ptr is updated by the playback_hw_thread.
  In the bluetooth_playback_delay() callback the snd_pcm_hwsync() function is called to
  update the "internal" hw ptr (io->hw_ptr) by calling the pointer callback (which returns data->hw_ptr).

  




I really would appreciate any help you can provide,
cheers,
stefan



--------------------------------------------
#include <stdio.h>
#include <stdint.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <pthread.h>
#include <time.h>
#include <alsa/asoundlib.h>
#include <alsa/pcm_external.h>

#define FILE_PERM	0644
#define ARRAY_SIZE(a) (sizeof(a)/sizeof((a)[0]))

#define DEBUG

#ifdef DEBUG
#define DBG(f, ...) \
    fprintf(stderr, "%s:%i %i "f"\n", __FUNCTION__, __LINE__, getpid(), ## __VA_ARGS__);
#else
#define DBG(f, ...)
#endif

struct play_info {
	snd_pcm_ioplug_t io;
	char *filename;
	int file_fd;
	snd_pcm_sframes_t hw_ptr;
};

static int snd_pcm_play_close(snd_pcm_ioplug_t *io)
{
	DBG("");
	return 0;
}

static int snd_pcm_play_start(snd_pcm_ioplug_t *io)
{
	DBG("");
	return 0;
}

static int snd_pcm_play_stop(snd_pcm_ioplug_t *io)
{
	DBG("");
	return 0;
}

static snd_pcm_sframes_t snd_pcm_play_pointer(snd_pcm_ioplug_t *io)
{
	struct play_info *data = io->private_data;
	
	DBG("ptr: %lu", data->hw_ptr);
	return data->hw_ptr;
}

static snd_pcm_sframes_t snd_pcm_play_transfer(snd_pcm_ioplug_t *io,
			const snd_pcm_channel_area_t *areas,
			snd_pcm_uframes_t offset,
			snd_pcm_uframes_t size)
{
	DBG("aborting with -EINVAL ...");
	return -EINVAL;
}

static int snd_pcm_play_prepare(snd_pcm_ioplug_t *io)
{
	struct play_info *data = io->private_data;
	
	DBG("hw_ptr -> 0");
	data->hw_ptr=0;

	return 0;
}

static int snd_pcm_play_hw_params(snd_pcm_ioplug_t *io,
                    snd_pcm_hw_params_t *params)
{

	return 0;
}

static int snd_pcm_play_poll_descriptors_count(snd_pcm_ioplug_t *io)
{
		DBG("");
	    return 1;
}


static int snd_pcm_play_poll_descriptors(snd_pcm_ioplug_t *io,
                    struct pollfd *pfd, unsigned int space)
{
	DBG("");
	return 1;
}

static int snd_pcm_play_poll_revents(snd_pcm_ioplug_t *io,
                    struct pollfd *pfds, unsigned int nfds,
	                unsigned short *revents)
{
	DBG("");
	return 0;
}

static int snd_pcm_play_delay(snd_pcm_ioplug_t *io, snd_pcm_sframes_t *delayp)
{
	DBG("");
	return 0;
}

static snd_pcm_ioplug_callback_t play_pcm_callback = {
    .close = snd_pcm_play_close,
    .start = snd_pcm_play_start,
    .stop = snd_pcm_play_stop,
    .pointer = snd_pcm_play_pointer,
    .transfer = snd_pcm_play_transfer,
	.prepare = snd_pcm_play_prepare,
	.hw_params = snd_pcm_play_hw_params,
	.poll_descriptors_count = snd_pcm_play_poll_descriptors_count,
	.poll_descriptors = snd_pcm_play_poll_descriptors,
	.poll_revents = snd_pcm_play_poll_revents,
	.delay = snd_pcm_play_delay,
};

static int play_hw_constraint(struct play_info * pcm)
{
	snd_pcm_ioplug_t *io = &pcm->io;


	static const snd_pcm_access_t access_list[] = {
		SND_PCM_ACCESS_RW_INTERLEAVED
	};
	static const unsigned int format_list[] = {
		SND_PCM_FORMAT_S16_LE,
	};

	int err;
	
	DBG("");

    /* access type */
    err = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_ACCESS,
                    ARRAY_SIZE(access_list), access_list);
    if (err < 0)
        return err;

    /* supported formats */
    err = snd_pcm_ioplug_set_param_list(io, SND_PCM_IOPLUG_HW_FORMAT,
                    ARRAY_SIZE(format_list), format_list);
    if (err < 0)
        return err;

    /* supported channels */
    err = snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_CHANNELS,
                            1, 1);
    if (err < 0)
        return err;

    /* supported rate */
    err = snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_RATE,
                            8000, 8000);
    if (err < 0)
        return err;

    /* supported block size */
    err = snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_PERIOD_BYTES,
                        156*2, 164*2);
    if (err < 0)
        return err;

    err = snd_pcm_ioplug_set_param_minmax(io, SND_PCM_IOPLUG_HW_PERIODS,
                                    2, 200);
    if (err < 0)
        return err;

	return 0;
}

SND_PCM_PLUGIN_DEFINE_FUNC(play)
{
	snd_config_iterator_t i, next;
	const char *filename=NULL;
	int err;
	struct play_info *play=NULL;

	if (stream != SND_PCM_STREAM_PLAYBACK)
	{
		SNDERR("play plugin can only be used for playback\n");
		return -1;
	}
	
	snd_config_for_each(i, next, conf) {
		snd_config_t *n = snd_config_iterator_entry(i);
		const char *id;
		if (snd_config_get_id(n, &id) < 0)
			continue;

		if (strcmp(id, "comment") == 0 || strcmp(id, "type") == 0 || strcmp(id, "hint") == 0)
			continue;

		if (strcmp(id, "filename") == 0) {
			if (snd_config_get_type(n) != SND_CONFIG_TYPE_STRING)
			{
				SNDERR("invalid type for %s\n", id);
				return -EINVAL;
			}

			if (snd_config_get_string(n, &filename)<0)
			{
				SNDERR("could not get filename for %s\n", id);
				return -EINVAL;
			}
			continue;
		}

		SNDERR("Unknown field %s", id);
		return -EINVAL;
	}

	if (!filename)
	{
		SNDERR("no filename defined or play plugin\n");
		return -EINVAL;
	}

	if ((play = calloc(1, sizeof(*play))) == NULL)
		return -ENOMEM;

	play->io.version = SND_PCM_IOPLUG_VERSION;
	play->io.name = "ALSA play Plugin";
	play->io.callback = &play_pcm_callback;
	play->io.private_data = play;
	play->io.mmap_rw = 0;

	if ((err = snd_pcm_ioplug_create(&play->io, name, stream, mode))<0)
	{
        free(play);
        return err;
    }
	
	err = play_hw_constraint(play);
	if (err < 0) {
		snd_pcm_ioplug_delete(&play->io);
		free(play);
		return err;
	}
	
	*pcmp = play->io.pcm;

	return err;
}

SND_PCM_PLUGIN_SYMBOL(play);
--------------------------------------------



