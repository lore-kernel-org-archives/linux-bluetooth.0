Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTin+dNkjySQBvCSLK9f5aRF9445UqjhXaNvKWSz_@mail.gmail.com>
References: <1287714419-13545-1-git-send-email-haijun.liu@atheros.com>
 <20101022171825.GA980@vigoh> <AANLkTi=C5biCuJV335yfNWkY77xK29aa5JQ+9xvaE1yr@mail.gmail.com>
 <20101025110131.GA7721@vigoh> <AANLkTin2RaOZbRbg4faCFUxMLVi-FoY2xnNqq0a8cHpN@mail.gmail.com>
 <AANLkTin+dNkjySQBvCSLK9f5aRF9445UqjhXaNvKWSz_@mail.gmail.com>
From: haijun liu <liuhaijun.er@gmail.com>
Date: Tue, 26 Oct 2010 15:35:36 +0800
Message-ID: <AANLkTinnsdK5G3F725HaWj3hO1_hToh0M3q+ZT6ZHOUv@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] Bluetooth: Fix system crash caused by del_timer()
To: shy <shyboysby@gmail.com>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	Haijun Liu <haijun.liu@atheros.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Shy,

> You can check the sk in list l2cap_sk_list.

If we use global lock, in case of mp env., we have to keep it locked
before exiting l2cap_monitor_timeout().

I don't know whether it can be accepted.


-- 
Haijun Liu
