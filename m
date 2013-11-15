Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Nov 2013 19:52:38 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCHv2 2/2] android: Add PTS PICS for HID
Message-ID: <20131115175238.GA13909@x220.p-661hnu-f1>
References: <1384435587-12427-1-git-send-email-jakub.tyszkowski@tieto.com>
 <1384512332-21906-1-git-send-email-jakub.tyszkowski@tieto.com>
 <1384512332-21906-3-git-send-email-jakub.tyszkowski@tieto.com>
 <CABBYNZ+v+HvN=oZx33SjMmJZQ4P1KswH9Cvs8FicQnLxg-Zd5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZ+v+HvN=oZx33SjMmJZQ4P1KswH9Cvs8FicQnLxg-Zd5w@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Nov 15, 2013, Luiz Augusto von Dentz wrote:
> Perhaps we should indicate which ones are mandatory, and obviously all
> the mandatory ones shall be enabled.

Indicating which are mandatory makes sense, but I don't think it's bad
if we just let the PICS reflect the current implementation status of
bluez.git. I.e. features stay disabled until they're actually
implemented. That would make it easy to track the point when all
mandatory features are completed.

Johan
