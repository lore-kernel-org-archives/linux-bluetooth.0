Return-Path: <cyrus@holtmann.org>
Date: Tue, 19 Nov 2013 18:35:27 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 0/2] PICS for GAP and HID
Message-ID: <20131119163527.GA12402@x220.p-661hnu-f1>
References: <1384871775-8348-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384871775-8348-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Tue, Nov 19, 2013, Jakub Tyszkowski wrote:
> Please note that some PICS marked as mandatory for LE were not
> selected because of Android 4.4 not supporting some LE Roles.
> 
> v3: layout changed, added: mandatory/optional/conditional
> 	markings and descriptions, # - not implemented mark
> v2: layout changed, each parameter description added
> v1: initial documents with PICS targeting Android 4.4
> 
> Jakub Tyszkowski (2):
>   android: Add PTS PICS for GAP
>   android: Add PTS PICS for HID
> 
>  android/pics-gap.txt | 708 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  android/pics-hid.txt | 285 +++++++++++++++++++++
>  2 files changed, 993 insertions(+)
>  create mode 100644 android/pics-gap.txt
>  create mode 100644 android/pics-hid.txt

Both patches have been applied. Thanks.

I did need to push an extra patch on top of these though since you
forgot to add the files to EXTRA_DIST in android/Makefile.am.

Johan
