Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <2d5a2c100710221315h683d18fch731f8b86e533daf3@mail.gmail.com>
Date: Mon, 22 Oct 2007 17:15:09 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <719D5CCC2F6E3644B0A9F5C9B1D0008803840FC4@esebe104.NOE.Nokia.com>
MIME-Version: 1.0
References: <719D5CCC2F6E3644B0A9F5C9B1D00088038171C2@esebe104.NOE.Nokia.com>
	<471730B2.3030606@free.fr>
	<Pine.LNX.4.64.0710181017560.28683@simba.math.ucla.edu>
	<719D5CCC2F6E3644B0A9F5C9B1D0008803840FC4@esebe104.NOE.Nokia.com>
Subject: Re: [Bluez-devel] PATCH1/2: bluez-utils -fix-a2dp-buffer-constraints
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Kai,

> ok, I'm very new to A2DP, but my understanding is that timing
> is done similarly as in RTP-over-IP: the receiver adapts to
> the clock of the sender. This means the sender just needs to
> send at a steady pace (not required, but makes life easier for
> the receiver). And as with RTP, I assume implementations vary
> a lot in quality, so improving the timing (reducing jitter
> and drift against nominal rate) will improve interoperability
> between different devices.
>
> Any ++agreed or --aggreed statements? :)

Yep, that is probably a good explanation why some devices
work better than others.

>
> >With bluez-utils-3.19 (3.20 is latest) I'm having consistently
> >good results sending to the Bluetooth ALSA device, with
> >neither silent gaps nor lost chunks.  But I'm seeing
> >corruption when going through PulseAudio, which is attributed
> >to an unknown formatting or parameter issue and is being dealt
> >with on their mailing list.
>

There is some misunderstanding about the buffer size we use, those
buffers are not intended to be used as ring buffers, it is just fill buffers
so when you got enough frames to send they are written in the socket
to device. The first buffer used (bluetooth_data) for pcm frames witch
should be the same size of the codesize, it is intend to buffer pcm
frames until it got enough data to encode a sbc frame than it should
be restarted. The second buffer (bluetooth_a2dp) is filled with sbc frames
it should have the mtu size of the l2cap, it stuff how many frames it can
in there until there is no space left for another frame. The pace should
be adjusted by the worker thread.

Making the buffer to be 16384 bytes long is nonsense we probably will never
use this, bluetooth_a2dp_write does not expect block sizes bigger than code=
size.
So we need to fix this as soon as possible.

One thing that may worth trying is to set the supported block sizes up to
the number of pcm frames it need to fill an entire packet, normally this
means 4-6 sbc frames so it would be 2kb to 3kb (each sbc frame
normally correspond to 512bytes).

-- =

Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
