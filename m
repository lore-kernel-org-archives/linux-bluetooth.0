Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5a2c100812081042v2b9f4688h3dafd6947a55ea5c@mail.gmail.com>
Date: Mon, 8 Dec 2008 15:42:23 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "Stuart Pook" <linux-bluetooth4@pook.es>
Subject: Re: bluez-4.22 + twinkle -> Unable to lock headset
Cc: "BlueZ development" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <493A6CC6.7000205@pook.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <48E29416.3030402@pook.es> <48EA6D84.7020101@pook.es>
	 <632D4195-1EFF-4191-98D9-4A0953223590@gmail.com>
	 <48EA7B66.1050208@pook.es>
	 <1223326990.11272.229.camel@violet.holtmann.net>
	 <48EA7ED9.9080801@pook.es>
	 <1223328106.11272.232.camel@violet.holtmann.net>
	 <48EA93F7.4060000@pook.es>
	 <14CF8002-9C68-48AF-AAB7-783C16CAC8CA@gmail.com>
	 <493A6CC6.7000205@pook.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

You basically already answer your question, if arecord -D JX10 -f
S16_LE | aplay -D JX10 -f S16_LE does work, twinkle should work too.
The problem seems to be that twinkle leaves the connection open and
attempt to acquire the lock again and again, this is probably a bad
use of alsa API by twinkle as snd_pcm_prepare should not be called
more than once.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
