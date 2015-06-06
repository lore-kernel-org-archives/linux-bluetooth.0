Return-Path: <cyrus@holtmann.org>
Message-ID: <55733250.3050402@hurleysoftware.com>
Date: Sat, 06 Jun 2015 13:48:00 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Arend van Spriel <arend@broadcom.com>,
 Ilya Faenson <ifaenson@broadcom.com>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 2/5] Intel based H4 line discipline enhancements
References: <1433365304-16707-1-git-send-email-ifaenson@broadcom.com> <1433365304-16707-3-git-send-email-ifaenson@broadcom.com> <85C2DD1E-DD05-4F42-8739-23B208A615A0@holtmann.org> <E0D3336E15B58B4294723AC879BA5E9425F717@IRVEXCHMB15.corp.ad.broadcom.com> <55731471.6000806@broadcom.com> <19D26D05-7156-4539-B89E-9402C2E62864@holtmann.org>
In-Reply-To: <19D26D05-7156-4539-B89E-9402C2E62864@holtmann.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 06/06/2015 12:39 PM, Marcel Holtmann wrote:
> However sparse run happens only after I already have the patch applied. If something goes wrong there, that is really wasting my time. And 0day testing bot will find it eventually as well.

FWIW, Greg uses a testing branch that the 0-day bot runs, and only later
moves those commits to -next.

Not that contributors shouldn't be using make C=2.

Regards,
Peter Hurley
