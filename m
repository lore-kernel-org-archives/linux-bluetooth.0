Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4496C13C.8000403@xmission.com>
Date: Mon, 19 Jun 2006 09:22:36 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <20060522154201.3cff8m3ju4w0ck4o@mail.blas.net>
	<4471D778.6030301@xmission.com>
In-Reply-To: <4471D778.6030301@xmission.com>
Subject: Re: [Bluez-devel] A few tests: a2play aborts when hanging up the
 call. That's not the way it should work.
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

db

>>While listening to stereo music with a2play, taking a call works (that the part
>>of the headset) and the a2play keeps on to stream during the call. Normal.
>>But when I hang up in order to go on and listen to the music the a2play detects
>>a connection reset by peer and aborts.

can you try this again by running "a2play -p" from cvs? I believe that
listening for messages on the control connection *during* playback was
where we were missing this, not in avrcp as I originally thought.

Brad


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
