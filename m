Return-Path: <cyrus@holtmann.org>
Date: Tue, 6 Apr 2010 19:11:31 +0100 (BST)
To: nirav rabara <niravrabara@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Question regarding HS Connection
In-Reply-To: <g2p912bb79a1004060553kdec12987gc9c957506b436c1e@mail.gmail.com>
References: <g2p912bb79a1004060553kdec12987gc9c957506b436c1e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1270577491.816321.874.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 6 Apr 2010, nirav rabara wrote:

> My question is if such the case than how to connect with HS?

you will probably find that because the HS device is very limited in
resources, it does not keep records of more than one paired device. So, if
you pair with another device it forgets about the first and you will not
be able to connect except that you pair it again.

some HS device might be able to store more than one pairing but I don't
know how you would find that out except by trying them all..

iain


