Return-Path: <jt@bougret.hpl.hp.com>
Date: Tue, 16 Sep 2003 17:36:09 -0700
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Stephen Crane <steve.crane@rococosoft.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] More SDP UUIDs...
Message-ID: <20030917003609.GA27263@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030915221624.GA17085@bougret.hpl.hp.com> <1063712005.22723.27.camel@pegasus> <20030916195333.GA25068@bougret.hpl.hp.com> <1063755753.29942.9.camel@pegasus> <20030917000637.GA26969@bougret.hpl.hp.com> <1063758501.29942.47.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1063758501.29942.47.camel@pegasus>
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, Sep 17, 2003 at 02:28:15AM +0200, Marcel Holtmann wrote:
> Hi Jean,
> 
> I forgot to mention that I started from scratch and the output you see
> above is a textual presentation of the new internal data structure. The
> core attributes id's and the UUID16's are decoded into strings, because
> they are unique. All other meanings of some data elements depends on
> others. I have to add some checks which makes sure that this is a valid
> SDP record, before I can do this.

	Well... What was wrong with the code I wrote in listattr.c ?
It did all of that properly and simply, and it was trivial to add new
UUIDs and attributes. I don't see what you have gained here...

> Regards
> 
> Marcel

	Jean
