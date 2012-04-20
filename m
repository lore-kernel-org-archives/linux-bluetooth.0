Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CA+XVXfeJ254A2kVTvpR6GyjAJvdNC_G6=840C9aDQjbeT+y_cQ@mail.gmail.com>
References: <1334786904-26282-1-git-send-email-jprvita@openbossa.org>
	<CA+XVXfeJ254A2kVTvpR6GyjAJvdNC_G6=840C9aDQjbeT+y_cQ@mail.gmail.com>
Date: Fri, 20 Apr 2012 14:06:02 -0300
Message-ID: <CAAngNMahrp2Umt3sR6QB7ex8zwNu-WsepbhdwUq1oUWcyy1e_g@mail.gmail.com>
Subject: Re: [RFC v2 00/16] HoG plugin
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-bluetooth@vger.kernel.org, claudio.takahasi@openbossa.org,
	Ido Yariv <ido@wizery.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Arik,

2012/4/19 Arik Nemtsov <arik@wizery.com>:
> 2012/4/19 João Paulo Rechi Vita <jprvita@openbossa.org>:
>> Second draft of the HoG plugin. Code went through a lot of refactoring and is
>> much cleaner now. The report descriptor parsing (to get the report id) is
>> hackish and it doesn't support more than one device simultaneosly, probably
>> due to a kernel bug (reports come from the wrong socket). We're investigating
>> it.
>
> Maybe this patch can help you? We encountered a similar issue with
> multiple devices.
>
> http://permalink.gmane.org/gmane.linux.bluez.kernel/22397
>

This patch fixes the problem for me, but it doesn't apply cleanly on
bluetooth-next anymore. I've manually made the changes with a very
small modification to make it more readable and re-commited on my tree
keeping the commit message and authorship. Can I re-send it to the
list? Or do you prefer to do it yourself? I've also added a tested-by
tag to it.

-- 
João Paulo Rechi Vita
Openbossa Labs - INdT
