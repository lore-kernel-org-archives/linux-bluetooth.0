Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix possible crash on startup
From: Bastien Nocera <hadess@hadess.net>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <f9d4bd30810141444peb2d641ge77ece807c7411ea@mail.gmail.com>
References: <1223766202.31961.868.camel@cookie.hadess.net>
	 <FA1352D8-03D2-4979-99A4-5EFE5EB8872E@gmail.com>
	 <2d5a2c100810130643h81e09f0qc3c9cd57602867e7@mail.gmail.com>
	 <1223907411.31961.3251.camel@cookie.hadess.net>
	 <f9d4bd30810141147o60a2b0ban3773a949b5c6c236@mail.gmail.com>
	 <f9d4bd30810141444peb2d641ge77ece807c7411ea@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 14 Oct 2008 23:51:58 +0100
Message-Id: <1224024718.5268.1016.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2008-10-14 at 18:44 -0300, Claudio Takahasi wrote:
<snip>
> Hi Bastien,
> 
> The patch that you sent is enough to fix this problem. There isn't
> error when parsing the service record, the illegal multibyte sequence
> error that I saw when debugging is a normal error when parsing
> "storage" files, it is exit condition.
> 
> I am just wondering how you created the sdp file that you sent me, did
> you remove some entries? My sdp file contains 18 entries, all of them
> are related to the Sony Ericsson K850.

None of those entries were created by hand. I believe this entry was
probably created with bluez 3.x, I only upgraded to bluez 4.x on my main
machine in the past week or so.

Cheers

