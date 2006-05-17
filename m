Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Message-ID: <70DCB28C5BB04A4BBB1C8512589BAC65CAADD0@MAIL006.mail.lan>
From: "Brand, Chris" <chris.brand@wideray.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Strange behaviour
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 17 May 2006 13:51:30 -0400

This is some test code that uses rfcomm to send data back and forth
between two hosts.
It seems to behave as expected to start with, but after a while data
stops flowing in one direction, and in the other direction it gets very
bursty.

This is on Fedora Core 4 (2.6.14 kernel) on one machine and FC3 (2.6.12)
on the other, with two identical CSR bluetooth modules :=20
hci0:	Type: USB
	BD Address: 00:02:5B:01:BE:72 ACL MTU: 384:8  SCO MTU: 64:8
	UP RUNNING PSCAN ISCAN=20
	RX bytes:18388796 acl:55829 sco:0 events:29399 errors:0
	TX bytes:14666019 acl:53268 sco:0 commands:24 errors:0
	Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3=20
	Link policy: RSWITCH HOLD SNIFF PARK=20
	Link mode: SLAVE ACCEPT=20
	Name: 'Spring'
	Class: 0x120104
	Service Classes: Networking, Object Transfer
	Device Class: Computer, Desktop workstation
	HCI Ver: n/a (0x3) HCI Rev: 0x77b LMP Ver: n/a (0x3) LMP Subver:
0x77b
	Manufacturer: Cambridge Silicon Radio (10)

Is this something wrong in my test code ? Is it a bug in the bluez stack
? Is it specific to this hardware ?

Any help would be much appreciated. Thanks.

Here's the code :

#include <arpa/inet.h>
#include <bits/sockaddr.h>
#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>
#include <bluetooth/rfcomm.h>
#include <errno.h>
#include <pthread.h>
#include <signal.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <linux/types.h>
#include <linux/irda.h>




#define ASSERT( aCondition, aResult, aMessage )		if
(!(aCondition)) {fprintf (stderr, "%s [%d]: %s (%d)\n", __FUNCTION__,
__LINE__, (aMessage), (aResult)); return (aResult);}
#define CHECK_RESULT( aResult, aMessage )			ASSERT
((aResult) =3D=3D 0, (aResult), (aMessage))
#define CHECK_BLOCK( aBlock, aResult, aMessage )	ASSERT ((aBlock)
!=3D NULL, (aResult), (aMessage))
#define DEBUG_LOG_STATUS(...)
fprintf (stderr, "[Status] "); fprintf (stderr, __VA_ARGS__); fprintf
(stderr, "\n")
//#define DEBUG_LOG_TRACE(...)
fprintf (stderr, "[Trace] %s:", __FUNCTION__); fprintf (stderr,
__VA_ARGS__); fprintf (stderr, "\n")
#define DEBUG_LOG_TRACE
#ifndef FALSE
#	define FALSE	(0)
#endif
#ifndef TRUE
#	define TRUE		(!(FALSE))
#endif
#define MEMBER_SIZEOF( aType, aMember )		sizeof ((const aType
*)(0)->aMember)


enum
{
	_kFCSSeed =3D 0xFFFF
};

enum
{
	_kOptRFCOMMChannel	=3D 'c',
	_kOptEcho			=3D 'e',
	_kOptHeaderSize		=3D 'H',
	_kOptMinPayload		=3D 'm',
	_kOptMaxPayload		=3D 'M',
	_kOptPayloadSize	=3D 'p',
	_kOptReverseRole	=3D 'r',
=09
	_kOptTakesArgument	=3D ':'
};

enum
{
	_kPrimaryModuleFlags =3D (1UL << HCI_UP) | (1UL << HCI_PSCAN) |
(1UL << HCI_ISCAN)
};

enum
{
	_kDefaultMTU =3D 256
};



typedef struct _COptions
{
	const char *	mServiceName;
	uint8_t			mChannel;
	int				mIsClient;
	int				mIsInitiator;
	ssize_t			mMinPayload;
	ssize_t			mMaxPayload;
	ssize_t			mHeaderSize;
	int				mEcho;
} _COptions;


typedef struct _CDiscoveryLog
{
	struct irda_device_list		mHeader;
	struct irda_device_info		mSlots01to0F [15];
} _CDiscoveryLog;


typedef struct _CTestPacketHeader
{
	uint16_t	mFCS;
	uint16_t	mSize;
	bdaddr_t	mSource;
	uint32_t	mSent;
	uint32_t	mReceived;
} _CTestPacketHeader __attribute__ ((packed));


typedef struct _CTestPacket
{
	_CTestPacketHeader	mHeader;
	uint8_t				mPayload [65532 - sizeof
(_CTestPacketHeader)];
} _CTestPacket __attribute__ ((packed));



static int					sReceiveCount;
static int					sQuit =3D FALSE;
static struct sigaction		sOnSIGINT;
static const uint16_t
fcstbl [256] =3D {
	0x0000, 0x1189, 0x2312, 0x329b, 0x4624, 0x57ad, 0x6536, 0x74bf,
	0x8c48, 0x9dc1, 0xaf5a, 0xbed3, 0xca6c, 0xdbe5, 0xe97e, 0xf8f7,
	0x1081, 0x0108, 0x3393, 0x221a, 0x56a5, 0x472c, 0x75b7, 0x643e,
	0x9cc9, 0x8d40, 0xbfdb, 0xae52, 0xdaed, 0xcb64, 0xf9ff, 0xe876,
	0x2102, 0x308b, 0x0210, 0x1399, 0x6726, 0x76af, 0x4434, 0x55bd,
	0xad4a, 0xbcc3, 0x8e58, 0x9fd1, 0xeb6e, 0xfae7, 0xc87c, 0xd9f5,
	0x3183, 0x200a, 0x1291, 0x0318, 0x77a7, 0x662e, 0x54b5, 0x453c,
	0xbdcb, 0xac42, 0x9ed9, 0x8f50, 0xfbef, 0xea66, 0xd8fd, 0xc974,
	0x4204, 0x538d, 0x6116, 0x709f, 0x0420, 0x15a9, 0x2732, 0x36bb,
	0xce4c, 0xdfc5, 0xed5e, 0xfcd7, 0x8868, 0x99e1, 0xab7a, 0xbaf3,
	0x5285, 0x430c, 0x7197, 0x601e, 0x14a1, 0x0528, 0x37b3, 0x263a,
	0xdecd, 0xcf44, 0xfddf, 0xec56, 0x98e9, 0x8960, 0xbbfb, 0xaa72,
	0x6306, 0x728f, 0x4014, 0x519d, 0x2522, 0x34ab, 0x0630, 0x17b9,
	0xef4e, 0xfec7, 0xcc5c, 0xddd5, 0xa96a, 0xb8e3, 0x8a78, 0x9bf1,
	0x7387, 0x620e, 0x5095, 0x411c, 0x35a3, 0x242a, 0x16b1, 0x0738,
	0xffcf, 0xee46, 0xdcdd, 0xcd54, 0xb9eb, 0xa862, 0x9af9, 0x8b70,
	0x8408, 0x9581, 0xa71a, 0xb693, 0xc22c, 0xd3a5, 0xe13e, 0xf0b7,
	0x0840, 0x19c9, 0x2b52, 0x3adb, 0x4e64, 0x5fed, 0x6d76, 0x7cff,
	0x9489, 0x8500, 0xb79b, 0xa612, 0xd2ad, 0xc324, 0xf1bf, 0xe036,
	0x18c1, 0x0948, 0x3bd3, 0x2a5a, 0x5ee5, 0x4f6c, 0x7df7, 0x6c7e,
	0xa50a, 0xb483, 0x8618, 0x9791, 0xe32e, 0xf2a7, 0xc03c, 0xd1b5,
	0x2942, 0x38cb, 0x0a50, 0x1bd9, 0x6f66, 0x7eef, 0x4c74, 0x5dfd,
	0xb58b, 0xa402, 0x9699, 0x8710, 0xf3af, 0xe226, 0xd0bd, 0xc134,
	0x39c3, 0x284a, 0x1ad1, 0x0b58, 0x7fe7, 0x6e6e, 0x5cf5, 0x4d7c,
	0xc60c, 0xd785, 0xe51e, 0xf497, 0x8028, 0x91a1, 0xa33a, 0xb2b3,
	0x4a44, 0x5bcd, 0x6956, 0x78df, 0x0c60, 0x1de9, 0x2f72, 0x3efb,
	0xd68d, 0xc704, 0xf59f, 0xe416, 0x90a9, 0x8120, 0xb3bb, 0xa232,
	0x5ac5, 0x4b4c, 0x79d7, 0x685e, 0x1ce1, 0x0d68, 0x3ff3, 0x2e7a,
	0xe70e, 0xf687, 0xc41c, 0xd595, 0xa12a, 0xb0a3, 0x8238, 0x93b1,
	0x6b46, 0x7acf, 0x4854, 0x59dd, 0x2d62, 0x3ceb, 0x0e70, 0x1ff9,
	0xf78f, 0xe606, 0xd49d, 0xc514, 0xb1ab, 0xa022, 0x92b9, 0x8330,
	0x7bc7, 0x6a4e, 0x58d5, 0x495c, 0x3de3, 0x2c6a, 0x1ef1, 0x0f78
};



static
void
_timeval_sub (
	const struct timeval *	inLHS,
	const struct timeval *	inRHS,
	struct timeval *		outResult)
{
	struct timeval	rhs =3D *inRHS;
=09
=09
	if (inLHS =3D=3D NULL  ||  inRHS =3D=3D NULL  ||  outResult =3D=3D =
NULL)
	{
		return;
	}
=09
	*outResult =3D *inLHS;
	rhs =3D *inRHS;
=09
	while (rhs.tv_usec >=3D 1000000)
	{
		rhs.tv_sec++;
		rhs.tv_usec -=3D 1000000;
	}
=09
	if (outResult->tv_usec >=3D rhs.tv_usec)
	{
		outResult->tv_usec -=3D rhs.tv_usec;
		outResult->tv_sec -=3D rhs.tv_sec;
	}
=09
	else
	{
		outResult->tv_usec =3D outResult->tv_usec + 1000000 -
rhs.tv_usec;
		outResult->tv_sec =3D outResult->tv_sec - 1 - rhs.tv_sec;
	}
=09
	while (outResult->tv_usec >=3D 1000000)
	{
		outResult->tv_sec++;
		outResult->tv_usec -=3D 1000000;
	}
}



static
int
_CheckPacket (
	const _CTestPacket *	inPacket)
{
	int			size;
	uint16_t	fcs =3D _kFCSSeed;
	uint8_t *	packet =3D (uint8_t *) &inPacket->mHeader.mSize;
	uint8_t		byte;
=09
=09
	CHECK_BLOCK (inPacket, FALSE, "null _CTestPacket");
=09
	for (
		size =3D ntohs (inPacket->mHeader.mSize) - sizeof
(inPacket->mHeader.mFCS);
		size > 0; --size)
	{
		byte =3D *packet++;
		fcs =3D (fcs >> 8) ^ fcstbl [(fcs ^ byte) & 0x00ff];
	}
=09
	return (fcs =3D=3D ntohs (inPacket->mHeader.mFCS));
}



static
size_t
_MakeTestPacket (
	bdaddr_t	inSource,
	uint32_t	inSent,
	uint32_t	inReceived,
	ssize_t		inMinPayload,
	ssize_t		inMaxPayload,
	_CTestPacket *	outPacket)
{
	ssize_t		range;
	ssize_t		size =3D inMinPayload;
	uint16_t	fcs =3D _kFCSSeed;
	int			offset;
	uint8_t *	packet =3D (uint8_t *) &outPacket->mHeader.mSize;
	uint8_t		byte;
=09
=09
	CHECK_BLOCK (outPacket, 0, "null _CTestPacket");
=09
	if (size < 0)
	{
		size =3D 0;
	}
=09
	else if (size > sizeof (outPacket->mPayload))
	{
		size =3D sizeof (outPacket->mPayload);
	}
=09
	if (size > inMaxPayload)
	{
		size =3D inMaxPayload;
	}
=09
	range =3D inMaxPayload - size;
=09
	if (range > sizeof (outPacket->mPayload) - size)
	{
		range =3D sizeof (outPacket->mPayload) - size;
	}
	DEBUG_LOG_TRACE ("min =3D %ld  range =3D %ld", size, range);=09
=09
	if (range > 0)
	{
		size +=3D rand () % (range + 1);
	}
=09
	outPacket->mHeader.mSize =3D htons (size + sizeof
(outPacket->mHeader));
	outPacket->mHeader.mSource =3D inSource;
	outPacket->mHeader.mSent =3D htonl (inSent);
	outPacket->mHeader.mReceived =3D htonl (inReceived);
=09
	for (
		offset =3D sizeof (outPacket->mHeader.mFCS);
		offset < sizeof (outPacket->mHeader);
		offset++)
	{
		byte =3D *packet++;
		fcs =3D (fcs >> 8) ^ fcstbl [(fcs ^ byte) & 0x00ff];
	}
=09
	while (size > 0)
	{
		--size;
		byte =3D rand ();
		*packet++ =3D byte;
		fcs =3D (fcs >> 8) ^ fcstbl [(fcs ^ byte) & 0x00ff];
	}
=09
	outPacket->mHeader.mFCS =3D htons (fcs);
=09
	ASSERT (_CheckPacket (outPacket), 0, "_MakeTestPacket () failed
_CheckPacket ()");
=09
	return ntohs (outPacket->mHeader.mSize);
}



static
int
_GetPacket (
	int				inSocket,
	_CTestPacket *	outPacket)
{
	int			result =3D 0;
	uint8_t *	packet =3D (uint8_t *) outPacket;
	size_t		expected =3D sizeof (outPacket->mHeader);
	size_t		allowed =3D sizeof (*outPacket);
	size_t		received =3D 0;
	int			size;
	int			check;
	uint8_t		overflow [256];
=09
=09
	CHECK_BLOCK (outPacket, EINVAL, "null _CTestPacket");
=09
=09
	// Get packet header:
=09
	do
	{
		size =3D read (inSocket, packet, expected - received);
	=09
		if (size > 0)
		{
			DEBUG_LOG_TRACE ("expected =3D %lu, received =3D
%lu", expected, received);
			received +=3D size;
			packet +=3D size;
		}
	}
	while (size > 0  &&  received < expected);
=09
	result =3D errno;
=09
	if (size < 0)
	{
		if (sQuit  ||  result =3D=3D ECONNRESET)
		{
			return result;
		}
	=09
		CHECK_RESULT (result, "read () failed");
		CHECK_RESULT (-1, "read () failed");
	}
=09
	ASSERT (!(received < expected), EIO, "received less than
expected");
=09
=09
	// Get payload:
=09
	expected =3D ntohs (outPacket->mHeader.mSize);
	DEBUG_LOG_STATUS ("Rx:
exp: %6lu", expected);
=09
	if (expected < sizeof (*outPacket))
	{
		allowed =3D expected;
	}
=09
	else
	{
		allowed =3D sizeof (*outPacket);
	}
=09
	while (size > 0  &&  received < allowed)
	{
		DEBUG_LOG_TRACE ("allowed =3D %lu, received =3D %lu",
allowed, received);
		size =3D read (inSocket, packet, allowed - received);
	=09
		if (size > 0)
		{
			received +=3D size;
			packet +=3D size;
		}
	}
=09
	while (size > 0  &&  received < expected)
	{
		DEBUG_LOG_TRACE ("expected =3D %lu, received =3D %lu",
expected, received);
		size =3D read (inSocket, overflow, sizeof (overflow));
	=09
		if (size > 0)
		{
			received +=3D size;
			packet +=3D size;
		}
	}
=09
	DEBUG_LOG_TRACE ("expected =3D %lu, received =3D %lu", expected,
received);
	result =3D errno;
=09
	if (size < 0)
	{
		if (sQuit  ||  result =3D=3D ECONNRESET)
		{
			return result;
		}
	=09
		CHECK_RESULT (result, "read () failed");
		CHECK_RESULT (-1, "read () failed");
	}
=09
	ASSERT (!(received < expected), EIO, "received less than
expected");
	ASSERT (!(received > expected), EIO, "received more than
expected");
=09
	if (size =3D=3D 0)
	{
		return ECONNRESET;
	}
=09
	return 0;
}



static
int
_Send (
	int				inSocket,
	const void *	inPacket,
	size_t			inSize,
	ssize_t			inHeaderSize)
{
	int					result =3D 0;
	const uint8_t *		packet =3D (const uint8_t *) inPacket;
	size_t				remaining;
	int					size =3D 0;
=09
=09
	ASSERT (inSize =3D=3D 0  ||  packet !=3D NULL, EINVAL, "null packet");
=09
	if (inSize >=3D inHeaderSize  &&  inHeaderSize > 0)
	{
		size =3D write (inSocket, packet, inHeaderSize);
	=09
		if (size > 0)
		{
			inSize -=3D size;
			packet +=3D size;
		}
	=09
		else
		{
			inSize =3D size;
		}
	}
=09
	while (inSize > 0)
	{
		size =3D write (inSocket, packet, inSize);
	=09
		if (size > 0)
		{
			inSize -=3D size;
			packet +=3D size;
		}
	=09
		else
		{
			inSize =3D size;
		}
	}
=09
	result =3D errno;
=09
	if (size < 0)
	{
		if (sQuit  ||  result =3D=3D ECONNRESET)
		{
			return result;
		}
	=09
		CHECK_RESULT (result, "write () failed");
		CHECK_RESULT (-1, "write () failed");
	}
=09
	return 0;
}



static
void *
_ReadThread (
	void *	arg)
{
	static _CTestPacket		sIn;
	int						sd =3D *(int *)
arg;
	int						error =3D 0;
	struct timeval			start;
	struct timeval			end;
	time_t					usec =3D 0;
	ssize_t					rate;
	int						size;
	int						ok;
	const char *			check =3D "";
	char					sourceName [32];
=09
=09
	while (!sQuit)
	{
		rate =3D 0;
		gettimeofday (&start, NULL);
	=09
		error =3D _GetPacket (sd, &sIn);
		gettimeofday (&end, NULL);
	=09
		if (sQuit  ||  error =3D=3D ECONNRESET)
		{
			return 0;
		}
	=09
		ASSERT ((error =3D=3D 0), NULL, "_GetPacket () failed");
	=09
		ok =3D _CheckPacket (&sIn);
	=09
		if (ok)
		{
			sReceiveCount++;
			check =3D "";
		}
	=09
		else
		{
			check =3D "  fcs [FAILED]";
		}
	=09
		DEBUG_LOG_TRACE ("start: sec =3D %ld  usec =3D %ld",
start.tv_sec, start.tv_usec);
		DEBUG_LOG_TRACE ("end: sec =3D %ld  usec =3D %ld",
end.tv_sec, end.tv_usec);
		_timeval_sub (&end, &start, &end);
		DEBUG_LOG_TRACE ("dur: sec =3D %ld  usec =3D %ld",
end.tv_sec, end.tv_usec);
		usec =3D (end.tv_sec * 1000000) + end.tv_usec;
	=09
		if (usec <=3D 0)
		{
			usec =3D 1;
		}
	=09
		ba2str (&sIn.mHeader.mSource, sourceName);
		size =3D ntohs (sIn.mHeader.mSize);
	=09
		DEBUG_LOG_STATUS (
			"Rx: src: %s  sent: %5lu  rcvd: %5lu  size:
%6d%s",
			sourceName,
			ntohl (sIn.mHeader.mSent),
			ntohl (sIn.mHeader.mReceived),
			size,
			check);
	=09
/*		size +=3D rate;
		rate =3D (((long long) size) * 8 * 1000000) / usec;
	=09
		DEBUG_LOG_STATUS (
			"RT:
size: %6d   ms: %5ld  bps: %6ld",
			size,
			((usec + 500) / 1000),
			rate);
*/	=09
		sched_yield ();
	}
}



static
int
_LoopTest (
	int					inSocket,
	const _COptions *	inOptions)
{
	static _CTestPacket		sOut;
	pthread_t				rx;
	uint32_t				sent =3D 0;
	socklen_t				optsize;
	int						error =3D 0;
	int						mtu =3D 0;
	ssize_t					min;
	ssize_t					max;
	struct sockaddr_rc		me;
	struct timeval			start;
	struct timeval			end;
	time_t					usec =3D 0;
	ssize_t					rate;
	int						size;
	char					sourceName [32];
=09
=09
/*	optsize =3D sizeof (mtu);
	error =3D getsockopt (inSocket, SOL_IRLMP, IRTTP_MAX_SDU_SIZE,
&mtu, &optsize);
=09
	if (error =3D=3D 0  &&  mtu > 0)
	{
		DEBUG_LOG_STATUS ("MTU =3D %d", mtu);
	}
=09
	else
	{
		mtu =3D 0;
	}
*/=09
	sReceiveCount =3D 0;
=09
	error =3D pthread_create (&rx, NULL, _ReadThread, &inSocket);
	CHECK_RESULT (error, "pthread_create () failed");
=09
	min =3D inOptions->mMinPayload;
	max =3D inOptions->mMaxPayload;
=09
	if (max < 0)
	{
		if (min > mtu)
		{
			max =3D min;
		}
	=09
		else
		{
			if (mtu <=3D 0)
			{
				mtu =3D _kDefaultMTU;
				DEBUG_LOG_STATUS ("MTU unknown. Assuming
%d", mtu);
			}
		=09
			max =3D mtu - sizeof (_CTestPacketHeader);
		}
	}
=09
	optsize =3D sizeof (me);
	getsockname (inSocket, (struct sockaddr *) &me, &optsize);
=09
=09
	while (!sQuit)
	{
		size =3D _MakeTestPacket (me.rc_bdaddr, sent,
sReceiveCount, min, max, &sOut);
		gettimeofday (&start, NULL);
		error =3D _Send (inSocket, &sOut, size,
inOptions->mHeaderSize);
	=09
		if (sQuit  ||  error =3D=3D ECONNRESET)
		{
			return 0;
		}
	=09
		CHECK_RESULT (error, "_Send () failed");
	=09
		sent++;
	=09
		ba2str (&sOut.mHeader.mSource, sourceName);
	=09
		DEBUG_LOG_STATUS (
			"Tx: src: %s  sent: %5lu  rcvd: %5lu  size:
%6d",
			sourceName,
			ntohl (sOut.mHeader.mSent),
			ntohl (sOut.mHeader.mReceived),
			ntohs (sOut.mHeader.mSize));
	=09
		sched_yield ();
	}
=09
	return 0;
}



static
int
_RfConnect (
	bdaddr_t			inPeer,
	const _COptions *	inOptions)
{
	int					error;
	int					sd =3D -1;
	struct sockaddr_rc	peer;
	char				peerName [32];
	int					size;
	char				buffer [2048];
=09
=09
	CHECK_BLOCK (inOptions, EINVAL, "null _COptions");

	memset (&peer, 0, sizeof (peer));
	peer.rc_family =3D AF_BLUETOOTH;
	peer.rc_bdaddr =3D inPeer;
	peer.rc_channel =3D inOptions->mChannel;
=09
	sd =3D socket (PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
=09
	if (sd =3D=3D -1)
	{
		CHECK_RESULT (errno, "socket () failed");
		CHECK_RESULT (-1, "socket () failed");
	}
=09
	ba2str (&peer.rc_bdaddr, peerName);
=09
	DEBUG_LOG_STATUS ("Connecting to [%s] CH [%d]...", peerName,
((int) peer.rc_channel));
	error =3D connect (sd, (const struct sockaddr *) (&peer), sizeof
(peer));
=09
	if (error !=3D 0)
	{
		close (sd);
		CHECK_RESULT (errno, "connect () failed");
		CHECK_RESULT (-1, "connect () failed");
	}
=09
	DEBUG_LOG_STATUS ("Connected");
=09
	error =3D _LoopTest (sd, inOptions);
=09
	if (error !=3D 0)
	{
		close (sd);
		CHECK_RESULT (error, "_LoopTest () failed");
	}
=09
	DEBUG_LOG_STATUS ("Disconnected");
	close (sd);
=09
	return 0;
}



static
int
_OnIsPrimaryModule (
	int		inSocket,
	int		inDeviceID,
	long	inContext)
{
=09
	struct hci_dev_info		info;
=09
=09
	(void) inContext;
=09
	DEBUG_LOG_TRACE ("_OnIsPrimaryModule (%d)", inDeviceID);
	if (hci_devinfo (inDeviceID, &info) !=3D 0)
	{
		return FALSE;
	}
=09
	DEBUG_LOG_TRACE ("_OnIsPrimaryModule: %s", info.name);
	return ((info.flags & _kPrimaryModuleFlags) =3D=3D
_kPrimaryModuleFlags);
}



static
int
_RfGetPrimaryBDA (
	bdaddr_t *	outBDA)
{
	int		hci =3D -1;
=09
=09
	CHECK_BLOCK (outBDA, EINVAL, "null bdaddr_t");
=09
	hci =3D hci_for_each_dev (HCI_UP, _OnIsPrimaryModule, 0L);
	ASSERT ((hci >=3D 0), ENODEV, "No bluetooth modules");
=09
	ASSERT ((hci_devba (hci, outBDA) =3D=3D 0), errno, "hci_devba ()
failed");
	return 0;
}



static
int
_RfListen (
	const _COptions *	inOptions)
{
	int					error;
	int					listener =3D -1;
	struct sockaddr_rc	local;
	bdaddr_t			primary;
	char				localName [32];
	struct sockaddr_rc	peer;
	char				peerName [32];
	int					connection;
	socklen_t			size =3D 0;
=09
=09
	CHECK_BLOCK (inOptions, EINVAL, "null _COptions");
=09
	memset (&local, 0, sizeof (local));
	local.rc_family =3D AF_BLUETOOTH;
	local.rc_bdaddr =3D *BDADDR_ANY;
	local.rc_channel =3D inOptions->mChannel;
=09
	listener =3D socket (PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
=09
	if (listener =3D=3D -1)
	{
		CHECK_RESULT (errno, "socket () failed");
		CHECK_RESULT (-1, "socket () failed");
	}
=09
	error =3D bind (listener, (const struct sockaddr *) &local, sizeof
(local));
=09
	if (error !=3D 0)
	{
		close (listener);
		CHECK_RESULT (errno, "connect () failed");
		CHECK_RESULT (-1, "connect () failed");
	}
=09
	error =3D listen (listener, 1);
=09
	if (error !=3D 0)
	{
		close (listener);
		CHECK_RESULT (errno, "listen () failed");
		CHECK_RESULT (-1, "listen () failed");
	}
=09
	size =3D sizeof (local);
	getsockname (listener, (struct sockaddr *) &local, &size);
	CHECK_RESULT (_RfGetPrimaryBDA (&primary), "_RfGetPrimaryBDA ()
failed");
	ba2str (&primary, localName);
	DEBUG_LOG_STATUS (
		"Waiting for connection to [%s] CH [%d]...", localName,
		((int) local.rc_channel));
=09
	size =3D sizeof (peer);
	connection =3D accept (listener, (struct sockaddr *) &peer,
&size);
	error =3D errno;
	close (listener);
=09
	if (connection =3D=3D -1)
	{
		if (sQuit)
		{
			return 0;
		}
	=09
		CHECK_RESULT (error, "accept () failed");
		CHECK_RESULT (-1, "accept () failed");
	}
=09
	DEBUG_LOG_STATUS ("Connected");
=09
	error =3D _LoopTest (connection, inOptions);
=09
	if (error !=3D 0)
	{
		close (connection);
		CHECK_RESULT (error, "_LoopTest () failed");
	}
=09
	DEBUG_LOG_STATUS ("Disconnected");
	close (connection);
=09
	return 0;
}



static
uint32_t
_GetPeer (
	void)
{
	int				sd =3D -1;
	_CDiscoveryLog	log;
	socklen_t		size =3D sizeof (log);
	int				index;
=09
=09
	sd =3D socket (AF_IRDA, SOCK_SEQPACKET, 0);
	ASSERT (sd !=3D -1, 0, "socket () failed");
=09
	memset (&log, 0, sizeof (log));
=09
	if (getsockopt (sd, SOL_IRLMP, IRLMP_ENUMDEVICES, &log, &size)
!=3D 0)
	{
		ASSERT (FALSE, 0, "getsockopt (IRLMP_ENUMDEVICES)
failed");
	}
=09
	close (sd);
=09
	for (index =3D 0; index < log.mHeader.len; index++)
	{
		if (log.mHeader.dev [index].daddr !=3D 0)
		{
			DEBUG_LOG_STATUS ("Found \"%s\"",
log.mHeader.dev [index].info);
			return log.mHeader.dev [index].daddr;
		}
	}
=09
	DEBUG_LOG_STATUS ("no devices");
	return 0;
}



static
void
_OnSIGINT (
	int				signo,
	siginfo_t *		info,
	void *			context)
{
	if (sQuit > 1)
	{
		sigaction (SIGINT, &sOnSIGINT, NULL);
	}
=09
	sQuit++;
}



static
void
_PrintUsage (
	const char	inName [])
{
	const char *	parse;
=09
=09
	for (parse =3D inName; *parse !=3D '\0'; parse++)
	{
		if (*parse =3D=3D '/')
		{
			parse++;
		=09
			if (*parse =3D=3D '\0')
			{
				break;
			}
		=09
			inName =3D parse;
		}
	}
=09
	fprintf (
		stderr,
		"Usage: %s -c <channel> [OPTION]... [TARGET_BDA]\n"
		"Send and receive RFCOMM messages in the following
format.  Offsets and sizes\n"
		"are in octets, and field values are in network byte
order.\n"
		"\n"
		"OFFSET       SIZE   FIELD\n"
		"     0          2   FCS        RFC 1171 CRC from next
field to end of message\n"
		"     2          2   Size       Size of message from
offset 0 to end of message\n"
		"     4          6   Source     IrLAP address of message
originator\n"
		"    10          4   Sent       Number of messages
origniator sent before this\n"
		"    14          4   Received   Number of valid messages
originator has received\n"
		"    18  Size - 18   Payload    Random data.  The
payload size varies randomly\n"
		"                               within the range
determined by -m, -M, and -p\n"
		"                               options or their
defaults.\n"
		"\n"
		"\n"
		"A -c option is required.\n"
		"\n"
		"Protocol Options:\n"
		"  -c <channel>   client mode, where <channel> is the
RFCOMM channel to\n"
		"                 which to connect.  Overrides any
previous -c options.\n"
		"\n"
		"Data Options:\n"
		"  -m <size>      minimum payload size.  Overrides any
previous -m or -p\n"
		"                 options. [Default: 0]\n"
		"  -M <size>      maximum payload size.  Overrides any
previous -M or -p\n"
		"                 options. [Default: fit to MTU]\n"
		"  -p <size>      exact payload size.  Overrides any
previous -m or -M\n"
		"                 options. [Default: see -m and -M]\n"
		"  -H <size>      send each message as a header of
<size> bytes followed by\n"
		"                 the rest of the message [Default:
0]\n"
		, inName
	);
}



int
main (
	int				argc,
	char * const	argv [])
{
	static const char	sOptionList [] =3D {
=09
_kOptRFCOMMChannel, _kOptTakesArgument,
//							_kOptEcho,
							_kOptHeaderSize,
_kOptTakesArgument,
							_kOptMinPayload,
_kOptTakesArgument,
							_kOptMaxPayload,
_kOptTakesArgument,
=09
_kOptPayloadSize, _kOptTakesArgument,
							_kOptReverseRole
						};
	struct sigaction	action;
	unsigned			seed =3D time (NULL);
	_COptions			options;
	int					opt;
	const char *		arg =3D NULL;
	int					reverse =3D FALSE;
	int					error;
	bdaddr_t			rfPeer;
=09
=09
	action.sa_handler =3D NULL;
	action.sa_flags =3D SA_SIGINFO;
	action.sa_sigaction =3D _OnSIGINT;
	sigemptyset (&action.sa_mask);
=09
//	sigaction (SIGINT, &action, &sOnSIGINT);
=09
	memset (&options, 0, sizeof (options));
	options.mMaxPayload =3D -1; // mtu
=09
	do
	{
		opt =3D getopt (argc, argv, sOptionList);
	=09
		if (optarg !=3D NULL  &&  optarg [0] =3D=3D '=3D')
		{
			arg =3D optarg + 1;
		}
	=09
		else
		{
			arg =3D optarg;
		}
	=09
		switch (opt)
		{
			case _kOptMaxPayload:
			{
				options.mMaxPayload =3D strtoul (arg,
NULL, 0);
			}
			break;
		=09
		=09
			case _kOptEcho:
			{
				options.mEcho =3D TRUE;
			}
			break;
		=09
		=09
			case _kOptHeaderSize:
			{
				options.mHeaderSize =3D strtoul (arg,
NULL, 0);
			}
			break;
		=09
		=09
			case _kOptReverseRole:
			{
				reverse =3D !reverse;
			}
			break;
		=09
		=09
			case _kOptMinPayload:
			{
				options.mMinPayload =3D strtoul (arg,
NULL, 0);
			}
			break;
		=09
		=09
			case _kOptPayloadSize:
			{
				options.mMinPayload =3D strtoul (arg,
NULL, 0);
			}
			break;
		=09
		=09
			case _kOptRFCOMMChannel:
			{
				options.mChannel =3D strtoul (arg, NULL,
0);
			}
			break;
		}
	}
	while (opt !=3D -1);
=09
=09
	if (options.mChannel =3D=3D 0)
	{
		_PrintUsage (argv [0]);
		return 1;
	}
=09
	if (optind < argc)
	{
		if (str2ba (argv [argc - 1], &rfPeer) !=3D 0)
		{
			_PrintUsage (argv [0]);
			return 1;
		}
	=09
		options.mIsClient =3D TRUE;
	}
=09
	if (reverse)
	{
		options.mIsInitiator =3D !options.mIsClient;
	}
=09
	else
	{
		options.mIsInitiator =3D options.mIsClient;
	}
=09
	srand (seed);
	DEBUG_LOG_STATUS ("Random seed =3D %u", seed);
=09
=09
	while (!sQuit)
	{
		if (options.mIsClient)
		{
			_RfConnect (rfPeer, &options);
		=09
			sleep (3);
		}
	=09
		else
		{
			error =3D _RfListen (&options);
			CHECK_RESULT (error, "_RfListen () failed");
		}
	}
=09
	return 0;
}
=20
Chris Brand
Senior Software Engineer
WideRay
604-233-1105
=20


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
