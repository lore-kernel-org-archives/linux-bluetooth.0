Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH 2/5] Intel based H4 line discipline enhancements
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <E0D3336E15B58B4294723AC879BA5E9425F717@IRVEXCHMB15.corp.ad.broadcom.com>
Date: Sat, 6 Jun 2015 17:50:31 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Arend Van Spriel <arend@broadcom.com>
Message-Id: <DF1E4B46-0AC1-4373-AA82-57EF64672992@holtmann.org>
References: <1433365304-16707-1-git-send-email-ifaenson@broadcom.com> <1433365304-16707-3-git-send-email-ifaenson@broadcom.com> <85C2DD1E-DD05-4F42-8739-23B208A615A0@holtmann.org> <E0D3336E15B58B4294723AC879BA5E9425F717@IRVEXCHMB15.corp.ad.broadcom.com>
To: Ilya Faenson <ifaenson@broadcom.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilya,

the mailing list has a strict policy of no top-posting. So please adhere to that. I know it is hard with corporate email systems, but for mailing list emails I am policing this.

> Appreciate you applying Fred's patches. I will now put together and post similar patches against the bluetooth-next proper.
> 
> Sorry for many minor changes. I just happen to run the checkpatch script automatically prior to publishing the patches (Arend taught me good Linux practices :-)) and that results in those spaces getting deleted et al.

Please keep in that you need --strict actually. We have to adhere to the network subsystem rules. Also some of the driver code is pretty old. You will find violations. Feel free to fix them, but please do it in a separate patch before your changes.

Regards

Marcel

