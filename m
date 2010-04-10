Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1270898546.5646.28.camel@localhost.localdomain>
References: <1270898546.5646.28.camel@localhost.localdomain>
Date: Sat, 10 Apr 2010 11:17:45 -0300
Message-ID: <l2r2a9506371004100717p500f6b4o48e8a6d2dfb8f0c5@mail.gmail.com>
Subject: Re: obexd-0.22 causes gnome-bluetooth sendto dialog to stop closing
	when operation ends
From: Vinicius Gomes <vinicius.gomes@openbossa.org>
To: pacho@condmat1.ciencias.uniovi.es
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pacho,

2010/4/10 Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>:
> Hello
>
> This is a regression over obexd-0.21. After updating to 0.22,
> gnome-bluetooth sendto dialog no longer closes when operation finishes,
> even if file is already properly sent.
>

We noticed this regression as well. Luiz already has a fix for this,
it was just not integrated yet.

In case you want to take a look and perhaps help test it, the fix is here[1].


Cheers,
-- 
Vinicius


[1] http://gitorious.org/~vudentz/obexd/vudentzs-clone (branch master)
