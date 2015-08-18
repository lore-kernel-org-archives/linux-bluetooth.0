Return-Path: <cyrus@holtmann.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, cpgs@samsung.com
References: <1439559396-12265-1-git-send-email-bharat.panda@samsung.com>
 <CABBYNZ+zvUZFeSzLZ2KA9k918jsNqQ=TYWJY6iBL9GfviQ0WrA@mail.gmail.com>
In-reply-to: <CABBYNZ+zvUZFeSzLZ2KA9k918jsNqQ=TYWJY6iBL9GfviQ0WrA@mail.gmail.com>
Subject: RE: [PATCH v2] audio/avrcp: Add Set Addressed Player support
Date: Tue, 18 Aug 2015 14:43:12 +0530
Message-id: <02f301d0d996$1ce1b460$56a51d20$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,


> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
> Sent: Monday, August 17, 2015 5:45 PM
> To: Bharat Panda
> Cc: linux-bluetooth@vger.kernel.org; cpgs@samsung.com
> Subject: Re: [PATCH v2] audio/avrcp: Add Set Addressed Player support
> 
> Hi Bharat,
> 
> On Fri, Aug 14, 2015 at 4:36 PM, Bharat Panda
> <bharat.panda@samsung.com> wrote:
> > Support added to handle Set Addressed Player PDU in TG role.
> > Send EVENT_ADDRESSED_PLAYER_CHANGED on SetAddressedPlayer
> SUCCESS and
> > follow procedure to reject all player specific events currently
> > registered with the player.
> >
> >       Channel: 64 len 15 [PSM 23 mode 0] {chan 0}
> >       AVCTP Control: Command: type 0x00 label 0 PID 0x110e
> >         AV/C: Control: address 0x48 opcode 0x00
> >           Subunit: Panel
> >           Opcode: Vendor Dependent
> >           Company ID: 0x001958
> >           AVRCP: SetAddressedPlayer pt Single len 0x0002
> >             PlayerID: 0x0000 (0)
> >
> >       Channel: 64 len 15 [PSM 23 mode 0] {chan 0}
> >       AVCTP Control: Response: type 0x00 label 0 PID 0x110e
> >         AV/C: Accepted: address 0x48 opcode 0x00
> >           Subunit: Panel
> >           Opcode: Vendor Dependent
> >           Company ID: 0x001958
> >           AVRCP: SetAddressedPlayer pt Single len 0x0002
> >             Status: 0x04 (Success)
> >
> >       Channel: 64 len 18 [PSM 23 mode 0] {chan 0}
> >       AVCTP Control: Response: type 0x00 label 0 PID 0x110e
> >         AV/C: Changed: address 0x48 opcode 0x00
> >           Subunit: Panel
> >           Opcode: Vendor Dependent
> >           Company ID: 0x001958
> >           AVRCP: RegisterNotification pt Single len 0x0005
> >             EventID: 0x0b (EVENT_ADDRESSED_PLAYER_CHANGED)
> >             PlayerID: 0x0000 (0)
> >             UIDCounter: 0x0000 (0)
> > ---
> 
> I went ahead and made some changes to make the code look simpler and
> reuse avrcp_player_event, please check if it still work as before.
I applied the patch with your changes, tested with Mecapp and PTS. It works fine.
> 
> --
> Luiz Augusto von Dentz

