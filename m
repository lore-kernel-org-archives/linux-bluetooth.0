Return-Path: <cyrus@holtmann.org>
Date: Tue, 19 Jul 2011 11:34:03 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: chen.ganir@gmail.com
Cc: linux-bluetooth@vger.kernel.org, Chen Ganir <chen.ganir@ti.com>
Subject: Re: [PATCH] Bluetooth : Added more testing options to l2test
Message-ID: <20110719143403.GA9194@joana>
References: <1311080951-15820-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1311080951-15820-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

* chen.ganir@gmail.com <chen.ganir@gmail.com> [2011-07-19 16:09:11 +0300]:

> From: Chen Ganir <chen.ganir@ti.com>
> 
> Added more options to allow passing ERTM L2CAP PTS tests. The 
> options allow to delay between a connection is made and the 
> first sent frame,a delay between the last sent frame and 
> disocnnection,and the ability to run as "one-shot" instead of
> listening for more connections.

I never needed such change to pass all ERTM PTS tests. Check if the -D and -C
options can help you.

	Gustavo
