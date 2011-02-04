Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Feb 2011 07:01:42 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	ankushbansal89@gmail.com, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Changing required GLIB version in acinclude.m4
Message-ID: <20110204050136.GE1551@jh-x301>
References: <ankushbansal89@gmail.com>
 <1296677045-12603-1-git-send-email-ankushbansal89@gmail.com>
 <AANLkTi=DdZzYtadsTTOO6Y-R=8Sq7x+EX46g7UDYa-7m@mail.gmail.com>
 <20110203200440.GD2168@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110203200440.GD2168@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Feb 03, 2011, Gustavo F. Padovan wrote:
> > Can you provide more details why this is needed, is there any new
> > function we are using which requires 2.16?
> 
> It is g_strcmp0(), but it should be a good idea add this info to the commit
> message.

I went ahead and added this to the patch. It has now been pushed
upstream.

Johan
