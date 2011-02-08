Return-Path: <cyrus@holtmann.org>
Message-ID: <6027B6444B774B019847152FB098B13F@freqoneremote>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: <dsaxena@plexity.net>,
	"BlueZ devel list" <linux-bluetooth@vger.kernel.org>
References: <20110207090836.GA26064@plexity.net>
In-Reply-To: <20110207090836.GA26064@plexity.net>
Subject: Re: Status of MAP and AVRCP
Date: Tue, 8 Feb 2011 08:42:47 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Deepak,


Hi,

I am wondering about the status of AVRCP and MAP profile support
in the current BlueZ tree. It looks like ther were a few GSOC
projects related to adding/extending these last year, but from
my quick skim, it does not look like these were integrated
upstream. Was an attempt made to push these changes and did
they get reject? Is someone still driving this work within the
BlueZ community to make sure it goes upstream?

+++++

I restarted work-in-earnest on an AVRCP layer a bit over two months ago (I 
also have a full-time day-job that has nothing to do with Bluetooth, Linux, 
Open Source, etc.). I am now resolving some issues in connecting from my 
custom built AVRCP remote (hardware and firmware), which connects, pairs, 
and connects with full AVRCP with my BlackBerry Torch, and the AVRCP stack 
on my laptop.  After working through that issue (I expect, by later this 
week), and verifying that the BB Torch can connect with my changes in place, 
I will complete fairly extensive testing and begin submitting patches with 
major surgery to audio/control.c, supporting the API doc worked out in the 
Portland meeting, with a couple of minor extensions.  This will bring BlueZ 
to AVRCP 1.3, figure by the end of this month.

I will also include message fragmentation support, which will be needed for 
1.4 (not really needed for 1.3, although it is in the 1.3 spec).  However, 
there are a number of issues with 1.4, the biggest being the amount of 
integration between the BlueZ stack/profile (which should remain pure) and 
the player(s), that are required to respond to queries for browsing track 
metadata, etc.  I think there will need to be a discussion about how much of 
1.4, if any, to support, and how.  I think Sander van Grieken's work with 
MPRIS may be a guide.  Also, I understand ST Ericsson (Shivendra Agrawal) is 
also proposing to provide 1.4 support.

Just my two cents...questions, please do not hesitate.

David Stockwell

+++++

Thanks,
~Deepak


-- 
"People think all we need to fix our predicament is a free source of
energy, but I think we need to change out behaviour. More energy would
just deplete the Earth's lifeblood faster." - Janine Benyius
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" 
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html 

