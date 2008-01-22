Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] bluetooth : move children of connection device to NULL
	before connection down
From: Marcel Holtmann <marcel@holtmann.org>
To: Dave Young <hidave.darkstar@gmail.com>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bluez-devel@lists.sourceforge.net,
	cornelia.huck@de.ibm.com, gombasg@sztaki.hu, htejun@gmail.com,
	viro@zeniv.linux.org.uk, kay.sievers@vrfy.org, greg@kroah.com
In-Reply-To: <a8e1da0801220024u30e9c814va74e44252fc8b11e@mail.gmail.com>
References: <20080121044913.GA4162@darkstar.te-china.tietoenator.com>
	 <20080121045401.GB4162@darkstar.te-china.tietoenator.com>
	 <20080121.031417.171098597.davem@davemloft.net>
	 <1200982696.7978.148.camel@aeonflux>
	 <a8e1da0801220024u30e9c814va74e44252fc8b11e@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 22 Jan 2008 12:39:20 +0100
Message-Id: <1201001960.7978.158.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Dave,

> could you tell something more about your coding style?
> I would like to submit patches about bluetooth according to your sytle
> later If I have.
> 
> Maybe you could put it on the bluez web site or anywhere.

it follows closely the kernel coding style as layout within the kernel
documentation. However there are some minor style things, that I am
going to enforce from time to time. Like having the container_of or
get_user_data calls at the top of the variable declaration. This has
never formalized as far as I recall, but makes from my point of view the
code clearer and easier to read.

Some other times I like an extra empty line to more visual separate
different code blocks. For this some people might agree with me others
might disagree. It is fully a personal more liking one way over the
other.

When it comes to indentation and placement of braces etc. I is 100% the
kernel coding style and nothing else. If not, then it needs fixing and
is an oversight from the old days.

Regards

Marcel


