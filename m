Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Jun 2015 10:11:19 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Florian Grandel <fgrandel@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [BlueZ v9 00/16] Multi-advertising
Message-ID: <20150618071119.GA13444@t440s.lan>
References: <1434166979-21824-1-git-send-email-fgrandel@gmail.com>
 <1434590266-26744-1-git-send-email-fgrandel@gmail.com>
 <20150618055552.GA11172@t440s.P-661HNU-F1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150618055552.GA11172@t440s.P-661HNU-F1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Florian,

On Thu, Jun 18, 2015, Johan Hedberg wrote:
> I've been running mgmt-tester with your latest kernel and user space
> patch sets, and there are four tests either failing or not getting run:
> 
> Read Advertising Features - Success 1 (No instance)  Failed       0.019 seconds
> Read Advertising Features - Success 2 (One instance) Failed       0.025 seconds
> Multi Advertising - Success 1 (Instance Switch)      Not Run
> Multi Advertising - Success 2 (Add Second Inst)      Failed       0.030 seconds
> 
> Are these passing for you?

False alarm. I had just failed to fully compile all of your kernel
patches. Now all the mgmt-tester tests pass for me. Sorry about the
confusion.

Johan
