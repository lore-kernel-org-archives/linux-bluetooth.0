Return-Path: <cyrus@holtmann.org>
Message-ID: <549403DF.4040404@jollamobile.com>
Date: Fri, 19 Dec 2014 12:54:23 +0200
From: Hannu Mallat <hannu.mallat@jollamobile.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] gdbus: use caller's bus name in polkit authorization
 check
References: <1415879499-920-1-git-send-email-hannu.mallat@jollamobile.com> <E76B9C62-EBB2-4D6F-9918-A4D85C101332@holtmann.org>
In-Reply-To: <E76B9C62-EBB2-4D6F-9918-A4D85C101332@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> so I wrote this code in 2009 as it seems. I can not even judge if my
> code is correct or your change is the correct one. It has been too
> long ago. You would need to convince me which one is the correct
> behavior when it comes to PolicyKit.

quoting polkit documentation for subject struct,

     "This struct describes subjects such as UNIX processes. It is
     typically used to check if a given process is authorized for
     an action."

so as far as I can see, the struct should describe the caller of
the D-Bus method, not bluetoothd itself, if the idea is to limit certain
methods to authorized callers only.

In the end I don't know if polkit offers much over D-Bus daemon based
authorization, and I chose not to use polkit for my needs, but wanted to
point out the issue nevertheless if someone else might face the same
problem.

BR,
H.
