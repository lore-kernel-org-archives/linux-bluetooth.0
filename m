Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Subject: Re: [PATCH] Coding style fixes
Date: Mon, 19 Jan 2009 12:00:44 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <200901172040.10674.siarhei.siamashka@nokia.com> <2d5a2c100901180711h33c099ddpe7d2ba2d804fa2c4@mail.gmail.com>
In-Reply-To: <2d5a2c100901180711h33c099ddpe7d2ba2d804fa2c4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901191200.44698.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sunday 18 January 2009 17:11:22 ext Luiz Augusto von Dentz wrote:
> Hi
>
> > And seriously, having "do { } while(0)" for a multiline macro is a must.
>
> Interesting, what does it do that { } doesn't?

By searching in the Internet it is possible to find some rationale for this:
http://vivekkutal.blogspot.com/2006/03/do-while0.html

Anyway, it is part of linux kernel CodingStyle

-- 
Best regards,
Siarhei Siamashka
