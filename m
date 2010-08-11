Return-Path: <cyrus@holtmann.org>
Message-ID: <1cd8783b41babbf611228c34a1fb5451.squirrel@www.codeaurora.org>
In-Reply-To: <1281485576-32715-1-git-send-email-ingas@codeaurora.org>
References: <1281485576-32715-1-git-send-email-ingas@codeaurora.org>
Date: Wed, 11 Aug 2010 09:26:49 -0700 (PDT)
Subject: Re: Support for HCI commands and events related to AMP
     functionality
From: ingas@codeaurora.org
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org,
 johan.hedberg@gmail.com,
 marcel@holtmann.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Just a clarification

> Added new HCI commands and events constructs for AMP related development.
> Will be used in updated testing tools for AMP.
>
>
> --
> Inga Stotland
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

These changes are needed first in hcidump tool (patches will come next) to
enable parsing of AMP commands. Even though these constructs are not going
to be used elsewhere in bluez git tree (at least initially), I felt that
for the sake of consistency they should live in hci.h
The subsequent updates to hcidump will depend on this patch set in bluez.

Inga

--
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
