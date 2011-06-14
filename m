Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Jun 2011 18:31:43 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Per-project patch prefixes
Message-ID: <20110614213143.GD2613@joana>
References: <20110614211507.GB27437@piper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110614211507.GB27437@piper>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-06-14 18:15:08 -0300]:

> Hi,
> 
> Now, this list receives patches for at least 3 different projects, so how
> about using different subject prefixes for each priject? The first thing
> that comes to mind is this:

This is a great idea. It can a lot when identifying patches, and you can do
this to the project's .git/config:

[format]
        subjectprefix = "bluetooth-next"


You may also want this(if you never configured it :

[sendemail]
        to = linux-bluetooth@vger.kernel.org

> 
> 1. kernel:
> 	- bluetooth-next -> for patches against Gustavo's bluetooth-next
> 	- bluetooth-current -> for patches against Gustavo's bluetooth-2.6
> 
> 2. BlueZ:
> 	- bluez
> 
> 3. obexd:
> 	- obexd

There is hcidump missing here.

	Gustavo
