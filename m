Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Karol Babioch <karol@babioch.de>
Subject: Re: Changed default configuration in bluez 4.97 and higher?
Date: Thu, 26 Jan 2012 15:40:32 +0100
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <4F204BDC.1010007@babioch.de> <4F2145AF.4050401@babioch.de> <4F2159DC.4090408@babioch.de>
In-Reply-To: <4F2159DC.4090408@babioch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID: <201201261540.32633.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Karol,

> So you were right, it seems that PulseAudio is the culprit here. However
> it works with bluez-4.96, although sockets are not enabled explicitly?
> So the question stays whether bluez 4.96 uses sockets implicitly, or
> whether PulseAudio doesn't work with bluez-4.98.

I guess it is distribution responsibility to provide proper configuration files
for software it includes. You should ask Arch people to fix it (either by
fixing PA or providing BT config that is usable with currently shipped PA).

-- 
BR
Szymon Janc
