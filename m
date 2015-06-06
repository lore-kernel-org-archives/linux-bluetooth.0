Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH 2/5] Intel based H4 line discipline enhancements
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <55731471.6000806@broadcom.com>
Date: Sat, 6 Jun 2015 18:39:10 +0200
Cc: Ilya Faenson <ifaenson@broadcom.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <19D26D05-7156-4539-B89E-9402C2E62864@holtmann.org>
References: <1433365304-16707-1-git-send-email-ifaenson@broadcom.com> <1433365304-16707-3-git-send-email-ifaenson@broadcom.com> <85C2DD1E-DD05-4F42-8739-23B208A615A0@holtmann.org> <E0D3336E15B58B4294723AC879BA5E9425F717@IRVEXCHMB15.corp.ad.broadcom.com> <55731471.6000806@broadcom.com>
To: Arend van Spriel <arend@broadcom.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arend,

>> Appreciate you applying Fred's patches. I will now put together and post similar patches against the bluetooth-next proper.
>> 
>> Sorry for many minor changes. I just happen to run the checkpatch script automatically prior to publishing the patches (Arend taught me good Linux practices :-)) and that results in those spaces getting deleted et al.
> 
> Actually, checkpatch by default only does the check and just tell you what is wrong. Normally, it would only warn about the thing your patch modified. Unless you ran checkpatch on source file.

personally it is even more important that people run make C=2 drivers/bluetooth/ to run the sparse and endian checks. Most of the coding style issues, I can spot in the email client before applying the patch. However sparse run happens only after I already have the patch applied. If something goes wrong there, that is really wasting my time. And 0day testing bot will find it eventually as well.

Regards

Marcel

