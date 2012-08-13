Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <E50901D4F2CF69428D43141B7C8586792CF109BB8B@EXMB03.eu.tieto.com>
References: <1344591300-1003-1-git-send-email-vani.patel@stericsson.com>
	<CABBYNZLMLCpfd_GzUMvtND6m0JJsuKLDCiyzvQAZkBrsV5U7vw@mail.gmail.com>
	<E50901D4F2CF69428D43141B7C8586792CF109BB8B@EXMB03.eu.tieto.com>
Date: Mon, 13 Aug 2012 15:15:09 +0300
Message-ID: <CABBYNZL-eDdFJbxuRxyCNDkhbSHNFVzH0rQQahj9FEdED81PcQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ V5 1/5] AVRCP: Add TG Record to support AVRCP Browsing
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michal.Labedzki@tieto.com
Cc: vani.patel@stericsson.com, linux-bluetooth@vger.kernel.org,
	Joohi.rastogi@stericsson.com, vani273@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Mon, Aug 13, 2012 at 2:49 PM,  <Michal.Labedzki@tieto.com> wrote:
> According to the specification we should not expose browsing in feature bits:
> "*4: Bit 6 (Browsing supported) is not set based on category. Bit 6 in the SDP record shall only be set if
> browsing of the "Media Player Virtual Filesystem" is supported."
>
> So no GetFolderItems on VFS scope - no browsing.

Well since SDP actually rely on the player to support that feature so
we might actually make it always be set and if the player doesn't
support we return an error or empty list. The spec itself states that
PlayerFeatureBitmask should be used instead, so the way I interpreted
it is that Bit 6 is there to tell if the transport support that not
the player itself.

-- 
Luiz Augusto von Dentz
