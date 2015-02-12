Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Feb 2015 13:34:14 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ethan <ethancsge@gmail.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 3.19-rc1 refuse connection from bluetooth headset
Message-ID: <20150212113414.GA29887@t440s.lan>
References: <201412241815.12922@pali>
 <201412241932.27264@pali>
 <20141224183737.GA21428@t440s.P-661HNU-DI-F1>
 <201412241941.56927@pali>
 <CAAAJ3CKFJ38pZF6WSD495W8JQmxBs1NcBDnag1q4qWhUE2_5qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAAAJ3CKFJ38pZF6WSD495W8JQmxBs1NcBDnag1q4qWhUE2_5qQ@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ethan,

On Thu, Feb 12, 2015, Ethan wrote:
> I met similar issue in kernel 3.10 for Chromebook smart lock feature, I
> have merged your patch but issue still happened.

The whole feature of checking the whitelist when HCI_CONNECTABLE is not
set was introduced only in kernel version 3.18. So it makes no sense to
try to backport my patch to 3.10. If you have issues with 3.10 without
my patch then it's something else that's going on and that deserves a
separate email thread.

Johan
