Return-Path: <cyrus@holtmann.org>
Message-ID: <10446.40010.qm@web52604.mail.re2.yahoo.com>
References: <91473.91180.qm@web52605.mail.re2.yahoo.com>  <1262969995.2233.5.camel@localhost.localdomain>  <370999.25109.qm@web52601.mail.re2.yahoo.com> <1262977847.2233.7.camel@localhost.localdomain>
Date: Fri, 8 Jan 2010 12:17:22 -0800 (PST)
From: Ed Tsang <netdesign_98@yahoo.com>
Subject: Re: bluetooth-sendto dbus-timeout
To: Bastien Nocera <hadess@hadess.net>
Cc: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1262977847.2233.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

>Don't top-post, and try gnome-bluetooth 2.28.6 (the latest stable
>release, which contains bluetooth-sendto bug fixes).
Tired gnome-blueooth 2.28.6 - similar result "Did not receive a reply..."
>From hcidump I could see a few seconds later (~7s)  there is a 
 < ACL ... RFCOMM.. DISC
So I will guess there is another timeout trigger the DISC sending out.
  Is there a way to make the d-bus method time out much longer. I tried to search the dbus tutorial and only find out that we need to handle the "DBUS_GERROR_REMOTE_EXCEPTION".

Regards,
Ed



      __________________________________________________________________
Ask a question on any topic and get answers from real people. Go to Yahoo! Answers and share what you know at http://ca.answers.yahoo.com
