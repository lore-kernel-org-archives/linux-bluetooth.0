Return-Path: <cyrus@holtmann.org>
Message-ID: <4BE96910.7090602@gmail.com>
Date: Tue, 11 May 2010 07:26:24 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Jiri Kosina <jkosina@suse.cz>
CC: linux-bluetooth@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: magicmouse: claimed by neither input, hiddev nor hidraw
References: <j2idd18b0c31005101341o43b652c1zf8729f5f9a60e0d3@mail.gmail.com>  <alpine.LRH.2.00.1005102334140.14809@twin.jikos.cz> <s2odd18b0c31005101439v22d03bfdw4e65d7c4b8315b6a@mail.gmail.com> <alpine.LNX.2.00.1005102351220.28092@pobox.suse.cz>
In-Reply-To: <alpine.LNX.2.00.1005102351220.28092@pobox.suse.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

o.k... I went and tested individual commits
and right now if I git revert 28918c
on the latest head, I don't receive
the "claimed by neither input, hiddev nor hidraw"
message, and I get all functionality back with the mouse.
(without having hiddraw enabled in the kernel.

Justin P. Mattock
