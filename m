Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4348AF2B.4030301@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Nokia 770 and bluetooth audio
References: <4346F84D.8050004@xmission.com> <1128774836.5212.4.camel@blade>
In-Reply-To: <1128774836.5212.4.camel@blade>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Sat, 08 Oct 2005 23:48:27 -0600

Marcel

> if I am not mistaken, then the integration into GStreamer will solve all
> the problems. However we need a good SBC encoder for this first. May you
> wanna give an update on its current status.

Victor's changes to our encoder give reasonable performance on arm (<10% 
of cpu on an arm9 400mhz I think). It uses 64-bit integer math and we 
expect there is room for even more optimization using a lossier 32-bit 
version (the 32-bit stuff is stubbed out but disabled for now since it's 
incomplete)

In addition to switching to integer ops, Victor unrolled loops and 
reworked some of the tables so less stuff has to be computed at runtime.

Real-world testing and dev work remain, so if someone has one of these 
Nokias already, please pipe up so we can give the encoder a workout.

Brad


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
