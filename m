Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Dec 2008 20:06:14 +0900
From: Chan-Yeol Park <chanyeol.park@samsung.com>
Subject: Does anyone know how to change the a2dp audio output stream between
 Speaker and bluetooth stereo headset?
To: linux-bluetooth@vger.kernel.org
Cc: =?ks_c_5601-1987?B?udq89sH4L1MvVyBQbGF0Zm9ybSBMYWIuKMXrvcW/rCkvRQ==?=
	 =?ks_c_5601-1987?B?NSjDpcDTKS+777y6wPzA2g==?=
	<cooliceman@samsung.com>
Message-id: <003301c964ee$78dd8fb0$6a98af10$%park@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=ks_c_5601-1987
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear All

Does anyone know how to change the a2dp audio output stream properly
between Speaker and Bluetooth stereo headset?

When we disconnect headset while we listen to A2DP, I think local device
should change the output stream to speaker or earphone.
I think it¡¯s totally rely on Gstreamer control. 
I use Gstreamer and Alsa bluez Plugin. 

Maybe.. I think anybody already think about this problem..and there is a
specialist. ^^


Moreover there is another problem. 
That is a video play case. 

When we play it, it¡¯s difficult to synchronize audio/video. 
I think it¡¯s much more difficult than just audio case¡¦.


Regards
ChanYeol, Park


