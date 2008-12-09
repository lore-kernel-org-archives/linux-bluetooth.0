Return-Path: <cyrus@holtmann.org>
Message-ID: <c2a31c480812090423o66229619ob7f7848d04106938@mail.gmail.com>
Date: Tue, 9 Dec 2008 17:53:56 +0530
From: "sreevani medhahal" <sreevani.medhahal@gmail.com>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: bluez-4.22 + twinkle -> Unable to lock headset
Cc: "Stuart Pook" <linux-bluetooth4@pook.es>
In-Reply-To: <2d5a2c100812081042v2b9f4688h3dafd6947a55ea5c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <48E29416.3030402@pook.es>
	 <632D4195-1EFF-4191-98D9-4A0953223590@gmail.com>
	 <48EA7B66.1050208@pook.es>
	 <1223326990.11272.229.camel@violet.holtmann.net>
	 <48EA7ED9.9080801@pook.es>
	 <1223328106.11272.232.camel@violet.holtmann.net>
	 <48EA93F7.4060000@pook.es>
	 <14CF8002-9C68-48AF-AAB7-783C16CAC8CA@gmail.com>
	 <493A6CC6.7000205@pook.es>
	 <2d5a2c100812081042v2b9f4688h3dafd6947a55ea5c@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
 I too face the similar issue with Skype. Is there any workaround to
sort this issue.
contents of asoundrc:
Headset used Planetronics:P590
pcm.bluetooth {
        type bluetooth
        device 00:19:7F:22:B7:8A
        profile "voice"
}

version of Bluez used:4.17
kernel:2.6.27

Snippet of the /var/log/messages
Dec  9 14:34:07 training01 bluetoothd[15235]: Accepted new client
connection on unix socket (fd=25)
Dec  9 14:34:07 training01 bluetoothd[15235]: Audio API: received
BT_GETCAPABILITIES_REQ
Dec  9 14:34:07 training01 bluetoothd[15235]: Audio API: sending
BT_GETCAPABILITIES_RSP
Dec  9 14:34:07 training01 bluetoothd[15235]: Unix client disconnected (fd=25)
Dec  9 14:34:07 training01 bluetoothd[15235]: Accepted new client
connection on unix socket (fd=25)
Dec  9 14:34:07 training01 bluetoothd[15235]: Audio API: received
BT_GETCAPABILITIES_REQ
Dec  9 14:34:07 training01 bluetoothd[15235]: Audio API: sending
BT_GETCAPABILITIES_RSP
Dec  9 14:34:07 training01 bluetoothd[15235]: Audio API: received
BT_SETCONFIGURATION_REQ
Dec  9 14:34:07 training01 bluetoothd[15235]: config sco - device =
00:19:7F:22:B7:8A access_mode = 2
Dec  9 14:34:07 training01 bluetoothd[15235]: State changed
/org/bluez/hci0/dev_00_19_7F_22_B7_8A: HEADSET_STATE_CONNECTED ->
HEADSET_STATE_PLAY_IN_PROGRESS
Dec  9 14:34:47 training01 bluetoothd[15235]: connect(): Connection
timed out (110)
Dec  9 14:34:47 training01 bluetoothd[15235]: Unable to lock headset
Dec  9 14:34:47 training01 bluetoothd[15235]: config failed
Dec  9 14:34:47 training01 bluetoothd[15235]: Audio API: sending
BT_SETCONFIGURATION_RSP

Regards,
Sreevani M
On Tue, Dec 9, 2008 at 12:12 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> You basically already answer your question, if arecord -D JX10 -f
> S16_LE | aplay -D JX10 -f S16_LE does work, twinkle should work too.
> The problem seems to be that twinkle leaves the connection open and
> attempt to acquire the lock again and again, this is probably a bad
> use of alsa API by twinkle as snd_pcm_prepare should not be called
> more than once.
>
> --
> Luiz Augusto von Dentz
> Engenheiro de Computação
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
