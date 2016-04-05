Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1459834240.2933.3.camel@localmomentum.net>
Subject: Re: [RFC v2] doc: Add DeviceBR1 and DeviceLE1 interfaces
From: Johnny Robeson <johnny@localmomentum.net>
Reply-To: johnny@localmomentum.net
To: Szymon Janc <szymon.janc@codecoup.pl>,
	linux-bluetooth@vger.kernel.org
Date: Tue, 05 Apr 2016 01:30:40 -0400
In-Reply-To: <1459732924-26643-2-git-send-email-szymon.janc@codecoup.pl>
References: <1459732924-26643-1-git-send-email-szymon.janc@codecoup.pl>
	 <1459732924-26643-2-git-send-email-szymon.janc@codecoup.pl>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Can you expose the LE address type here too as a readonly method?


This is currently available in the management api here as seen here: ht
tp://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/mgmt-
api.txt?id=60d28644cab85f2b75cd760f916049387ce8a248#n2159

Also, can you clarify how included and/or secondary services are
handled?
