Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Sep 2014 11:06:13 +0200
From: Alexander Aring <alex.aring@gmail.com>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	alan@signal11.us, Varka Bhadram <varkab@cdac.in>
Subject: Re: [PATCH bluetooth-next v2 0/3] cleanup for mrf24j40 driver
Message-ID: <20140919090611.GA17051@omega>
References: <1411101911-12462-1-git-send-email-varkab@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1411101911-12462-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Varka,

nice to read you again. :-) I already thought that I was maybe a little
bit too harsh to you for explaining changing dev->add_len during runtime
will occur in unexcept behaviour. Sorry.

Nevertheless welcome back. I want to apply it when Alan finally sends a
"Acked-by: ...", but why is this tagged with bluetooth-next?

There are other mrf24j40 patches around and it's better to send this in
a whole patch series when all patches are on wpan-next/testing. Then I
will send these patches to bluetooth-next. When applied I will rebase
the wpan-next/master to bluetooth-next/master.

Only 6LOWPAN GENERIC patches should be send to bluetooth-next.

- Alex
