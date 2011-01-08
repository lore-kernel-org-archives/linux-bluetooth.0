Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1294438779.1615.12.camel@ubuntuLab1>
References: <1294438779.1615.12.camel@ubuntuLab1>
Date: Sat, 8 Jan 2011 16:59:13 -0300
Message-ID: <AANLkTi=06DpiLcZ7uoOgVpfF9CN3xYRBtxtz-3+ZYxPL@mail.gmail.com>
Subject: Re: running attrib/example.c server code
From: Vinicius Gomes <vinicius.gomes@openbossa.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Fri, Jan 7, 2011 at 7:19 PM, Brian Gix <bgix@codeaurora.org> wrote:
> Hi All,
>
> I am implementing the READ_BLOB functionality in the attrib-server, and
> I am trying to figure out how to run it.
>

IIRC, the only things needed to run the example server, are enabling
AttributeServer in /etc/bluetooth/main.conf and compiling bluez
passing the --enable-attrib configure option.

> The example.c has a built-in Attribute that will work for testing (the
> Thermometer: characteristic user description -- size 25 octets) but I
> can't discern what I need to run from the command line to activate these
> example services. The code is compiling, but I don't find any clues for
> invocation.
>
> Thanks for any help.
>
> --
> Brian Gix
> bgix@codeaurora.org
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


Cheers,
-- 
Vinicius
