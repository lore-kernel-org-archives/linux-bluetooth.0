Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451891E3763
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728057782; cv=pass; b=mUqeKRUI7QxaledVk7rIXyR3HzwWfnmSpcT5tnqzC8cZJkVU9KJDkOMmcV3OE37lfPZGgNr9ED9W8MyDEHTXfj5HDT2pqHvgIJKNcESLC5RsH34FWkFyUeSmpF3Qs1dRWfUWOdeLpxyugFdRHJjnzK723uiv5bc8v5nf0rGUUno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728057782; c=relaxed/simple;
	bh=qsT1xc8lLyM0xtWNHtPnvV9Qarrwf8VgLd6f0DU1YJk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=oMn8BaIWGMTPYCdkZ1+gfHuNc8ZZ0wmky2Xc2OTXyqTFCTjJtszAb2EczbLTVaCC6zGhjziy+t9A94jhFgZ5hXKRaji/P33KMhTinhY3ph7N5QA03QkHAQxE9v/2VIiqEVze9kh3O1pFimCLbjNHCKiAE1M1mhLkAST+/lRw1Bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b=d7VIKZan; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b="d7VIKZan"
ARC-Seal: i=1; a=rsa-sha256; t=1728057778; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QTjnak5x9AaImGeIHaUH/Lj8IoIkb1RZ59hlQOlasXU4B+x1xwpDC4KceawW7Ja4Apo+Ug9gOwIMuf19JJbc6EZe5dgOROZS07Yz56tIotpLTT/hZUzLKOPGAXtwYjoPJC1NpApqf7ZtqGIc2wmezcM/9BcQdTAGFGhWQ5evckw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1728057778; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=aVzomAYVADcO0boQ3TTvaLSqwF+U2rdkowc0OzUHWKo=; 
	b=Z0u8ybZVGAdbwBMuQwDSwQx+dzEm/BsSK52mKDwtWdmBy6AgpS+SX0vJL5PsBj4bbeqY7rFrqxircKdj4Jf7zLf2f9kMeabD2uqXj23hlinQXbpTFgQb9W7a5h/70BYbmNyQ875jVsHwWSInt1Vs6M9Vaeplg96tlA6UcX0Ezdg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=frederic.danis@collabora.com;
	dmarc=pass header.from=<frederic.danis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728057778;
	s=zohomail; d=collabora.com; i=frederic.danis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=aVzomAYVADcO0boQ3TTvaLSqwF+U2rdkowc0OzUHWKo=;
	b=d7VIKZanH5MCrygRqZpYXeEE0dD1rRiulm17oqlSApqJBft5ldIeOk+P1aA3Uynm
	Uj3epEZAaGIuvBZw1aSZQP0UevRZOomxGMoVePlh2GtEPpMJr66+2pTOvUjvRvaqUN/
	q+0fm57CJ0b1Rlf8dlgqQ5Fj0phozFoeOnbuSrMs=
Received: by mx.zohomail.com with SMTPS id 172805777565869.58033302211811;
	Fri, 4 Oct 2024 09:02:55 -0700 (PDT)
Message-ID: <acd02a0a-0ed8-43a2-a877-c80802d27350@collabora.com>
Date: Fri, 4 Oct 2024 18:02:53 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 0/3] Fix now playing list on playlist change
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
References: <20241004144043.419832-1-frederic.danis@collabora.com>
Content-Language: en-US
In-Reply-To: <20241004144043.419832-1-frederic.danis@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

On 04/10/2024 16:40, Frédéric Danis wrote:
> Some devices reuse the item ids for the Now Playing list on playlist
> change, e.g. using the Samsung Music on Samsung S23. These changes
> allows to clear the list and prevent to keep the previous tracks
> information.
> This also extend the ListItems method to get the Artist, Album,
> Track number, Duration and Cover art handle.
>
> This has been tested with Samsung S23 and iPhone 14.
>
> Frédéric Danis (3):
>    audio/player: Fix media_player_set_metadata item destination
>    audio/player: Clear playlist on Now Playing Changed AVRCP event
>    audio/avrcp: Extend ListItems to get more metadata
>
>   profiles/audio/avrcp.c  | 65 ++++++++++++++++++++++++++++++++---------
>   profiles/audio/avrcp.h  |  1 +
>   profiles/audio/player.c | 16 ++++++++--
>   profiles/audio/player.h |  1 +
>   4 files changed, 67 insertions(+), 16 deletions(-)
>
To be more clear and with samples here is what occurs in bluetoothctl 
currently, after playlist change on the phone only items with an UID 
greater than the last one of the previous playlist are displayed as new 
and metadata of the others are not updated:

    [bluetooth]# connect 24:24:B7:11:82:6C
    Attempting to connect to 24:24:B7:11:82:6C
    [bluetooth]# [CHG] Device 24:24:B7:11:82:6C Connected: yes
    [Frédéric's S23]# [NEW] Endpoint
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/sep3
    [Frédéric's S23]# [NEW] Endpoint
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/sep1
    [Frédéric's S23]# [NEW] Endpoint
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/sep2
    [Frédéric's S23]# [NEW] Endpoint
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/sep4
    [Frédéric's S23]# [NEW] Endpoint
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/sep5
    [Frédéric's S23]# [NEW] Transport
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/sep2/fd2
    [Frédéric's S23]# Connection successful
    [Frédéric's S23]# [NEW] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 [default]
    [Frédéric's S23]# [CHG] Device 24:24:B7:11:82:6C ServicesResolved: yes
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/Filesystem /Filesystem
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying /NowPlaying
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Type: Audio
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Subtype: Audio Book
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Status: paused
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Browsable: yes
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Playlist:
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Name: Samsung Music
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Repeat: off
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Shuffle: off
    [Frédéric's S23]# [NEW] Folder
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.Duration:
    0x00036a1b (223771)
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.Genre: Rock
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.Title: Death On
    Two Legs
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.Item:
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item1
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.TrackNumber:
    0x00000001 (1)
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.Artist: Queen
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.NumberOfTracks:
    0x0000000b (11)
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.Album: A Night
    At The Opera
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.ImgHandle: 0000004
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item1 <unknown>
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Position: 0x00000000 (0)
    [Frédéric's S23]# player.change-folder
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying
    Attempting to change folder
    [Frédéric's S23]# [CHG] Folder
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Name: /NowPlaying
    [Frédéric's S23]# ChangeFolder successful
    [Frédéric's S23]# player.list-items 0 50
    Attempting to list items
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item2
    Lazing On A Sunday Afternoon
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item3 I'm
    In Love With My Car
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item4
    You're My Best Friend
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item5 Sweet
    Lady
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item6
    Seaside Rendezvous
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item7 The
    Prophet's Song
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item8 Love
    Of My Life
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item9 Good
    Company
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item10
    Bohemian Rhapsody
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item11 God
    Save The Queen
    [Frédéric's S23]# ListItems successful
    [Frédéric's S23]# player.show-item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item2
    Item /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item2
         Player: /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0
         Name: Lazing On A Sunday Afternoon
         Type: audio
         Playable: yes
         Metadata.Title: Lazing On A Sunday Afternoon
    [CHG] Transport /org/bluez/hci0/dev_24_24_B7_11_82_6C/sep2/fd2
    State: pending
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Position: 0x0000012b (299)
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Status: playing
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Position: 0x00000151 (337)
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.Duration:
    0x0001a8e6 (108774)
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.Genre: <unknown>
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.Title: Prologue
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.Item:
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item1
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.TrackNumber:
    0x00000001 (1)
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.Artist: Toto
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.NumberOfTracks:
    0x00000011 (17)
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.Album: Dune
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.ImgHandle: 0000006
    [Frédéric's S23]# [CHG] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item1
    Metadata.Duration: 0x0001a8e6 (108774)
    [Frédéric's S23]# [CHG] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item1
    Metadata.Genre: <unknown>
    [Frédéric's S23]# [CHG] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item1
    Metadata.Title: Prologue
    [Frédéric's S23]# [CHG] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item1
    Metadata.TrackNumber: 0x00000001 (1)
    [Frédéric's S23]# [CHG] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item1
    Metadata.Artist: Toto
    [Frédéric's S23]# [CHG] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item1
    Metadata.NumberOfTracks: 0x00000011 (17)
    [Frédéric's S23]# [CHG] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item1
    Metadata.Album: Dune
    [Frédéric's S23]# [CHG] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item1
    Metadata.ImgHandle: 0000006
    [Frédéric's S23]# [CHG] Transport
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/sep2/fd2 State: active
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Position: 0x00000173 (371)
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Position: 0x00000058 (88)
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Status: paused
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Position: 0x00000058 (88)
    [Frédéric's S23]# [CHG] Transport
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/sep2/fd2 State: idle
    [Frédéric's S23]# list-items 0 50
    Attempting to list items
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item12
    Prelude (Take My Hand)
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item13 Paul
    Takes the Water of Life
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item14 Big
    Battle
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item15 Paul
    Kills Feyd
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item16
    Final Dream
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item17 Take
    My Hand
    [Frédéric's S23]# ListItems successful
    [Frédéric's S23]# player.show-item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item2
    Item /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item2
         Player: /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0
         Name: Lazing On A Sunday Afternoon
         Type: audio
         Playable: yes
         Metadata.Title: Lazing On A Sunday Afternoon

While with those commits, the items are deleted on playlist change and 
all new ones are created with correct metadata:

    [bluetooth]# connect 24:24:B7:11:82:6C
    Attempting to connect to 24:24:B7:11:82:6C
    [bluetooth]# [CHG] Device 24:24:B7:11:82:6C Connected: yes
    [Frédéric's S23]# [NEW] Endpoint
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/sep3
    [Frédéric's S23]# [NEW] Endpoint
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/sep1
    [Frédéric's S23]# [NEW] Endpoint
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/sep2
    [Frédéric's S23]# [NEW] Endpoint
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/sep4
    [Frédéric's S23]# [NEW] Endpoint
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/sep5
    [Frédéric's S23]# [NEW] Transport
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/sep2/fd0
    [Frédéric's S23]# Connection successful
    [Frédéric's S23]# [NEW] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 [default]
    [Frédéric's S23]# [CHG] Device 24:24:B7:11:82:6C ServicesResolved: yes
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Playlist is nil
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/Filesystem /Filesystem
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying /NowPlaying
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Type: Audio
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Subtype: Audio Book
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Status: paused
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Browsable: yes
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Playlist:
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Name: Samsung Music
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Repeat: off
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Shuffle: off
    [Frédéric's S23]# [NEW] Folder
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.Duration:
    0x00036a1b (223771)
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.Genre: Rock
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.Title: Death On
    Two Legs
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.Item:
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item1
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.TrackNumber:
    0x00000001 (1)
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.Artist: Queen
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.NumberOfTracks:
    0x0000000b (11)
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.Album: A Night
    At The Opera
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.ImgHandle: 0000004
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item1 <unknown>
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Position: 0x00000590
    (1424)
    [Frédéric's S23]# player.change-folder
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying
    Attempting to change folder
    [Frédéric's S23]# [CHG] Folder
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Name: /NowPlaying
    [Frédéric's S23]# ChangeFolder successful
    [Frédéric's S23]# player.list-items 0 50
    Attempting to list items
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item2
    Lazing On A Sunday Afternoon
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item3 I'm
    In Love With My Car
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item4
    You're My Best Friend
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item5 Sweet
    Lady
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item6
    Seaside Rendezvous
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item7 The
    Prophet's Song
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item8 Love
    Of My Life
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item9 Good
    Company
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item10
    Bohemian Rhapsody
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item11 God
    Save The Queen
    [Frédéric's S23]# show-item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item2
    Item /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item2
         Player: /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0
         Name: Lazing On A Sunday Afternoon
         Type: audio
         Playable: yes
         Metadata.Title: Lazing On A Sunday Afternoon
         Metadata.TrackNumber: 0x00000002 (2)
         Metadata.Duration: 0x0001077f (67455)
         Metadata.Album: A Night At The Opera
         Metadata.Artist: Queen
    [Frédéric's S23]# ListItems successful
    [Frédéric's S23]# [CHG] Transport
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/sep2/fd0 State: pending
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Status: playing
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Position: 0x00000598
    (1432)
    [Frédéric's S23]# [CHG] Transport
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/sep2/fd0 State: active
    [Frédéric's S23]# [CHG] Transport
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/sep2/fd0 State: idle
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Position: 0x00000598
    (1432)
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Status: paused
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Position: 0x00000598
    (1432)
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Position: 0x00000030 (48)
    [Frédéric's S23]# [CHG] Transport
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/sep2/fd0 State: pending
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Status: playing
    [Frédéric's S23]# [CHG] Transport
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/sep2/fd0 State: active
    [Frédéric's S23]# [DEL] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item11 God
    Save The Queen
    [Frédéric's S23]# [DEL] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item10
    Bohemian Rhapsody
    [Frédéric's S23]# [DEL] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item9 Good
    Company
    [Frédéric's S23]# [DEL] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item8 Love
    Of My Life
    [Frédéric's S23]# [DEL] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item7 The
    Prophet's Song
    [Frédéric's S23]# [DEL] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item6
    Seaside Rendezvous
    [Frédéric's S23]# [DEL] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item5 Sweet
    Lady
    [Frédéric's S23]# [DEL] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item4
    You're My Best Friend
    [Frédéric's S23]# [DEL] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item3 I'm
    In Love With My Car
    [Frédéric's S23]# [DEL] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item2
    Lazing On A Sunday Afternoon
    [Frédéric's S23]# [DEL] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item1 <unknown>
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Playlist:
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Position: 0x0000023e (574)
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.Duration:
    0x0001a8e6 (108774)
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.Genre: <unknown>
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.Title: Prologue
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.Item:
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item1
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.TrackNumber:
    0x00000001 (1)
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.Artist: Toto
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.NumberOfTracks:
    0x00000011 (17)
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.Album: Dune
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Track.ImgHandle: 0000006
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item1 <unknown>
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Position: 0x00000255 (597)
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Position: 0x00000000 (0)
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Status: paused
    [Frédéric's S23]# [CHG] Player
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 Position: 0x00000000 (0)
    [Frédéric's S23]# [CHG] Transport
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/sep2/fd0 State: idle
    [Frédéric's S23]# list-items 0 50
    Attempting to list items
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item2 Main
    Title
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item3 Robot
    Fight
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item4
    Leto's Theme
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item5 The Box
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item6 The
    Floating Fat Man (The Baron)
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item7 Trip
    to Arrakis
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item8 First
    Attack
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item9
    Prophecy Theme
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item10 Dune
    (Desert Theme)
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item11 Paul
    Meets Chani
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item12
    Prelude (Take My Hand)
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item13 Paul
    Takes the Water of Life
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item14 Big
    Battle
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item15 Paul
    Kills Feyd
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item16
    Final Dream
    [Frédéric's S23]# [NEW] Item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item17 Take
    My Hand
    [Frédéric's S23]# ListItems successful
    [Frédéric's S23]# player.show-item
    /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item2
    Item /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item2
         Player: /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0
         Name: Main Title
         Type: audio
         Playable: yes
         Metadata.Title: Main Title
         Metadata.TrackNumber: 0x00000002 (2)
         Metadata.Duration: 0x00013c54 (80980)
         Metadata.Album: Dune
         Metadata.Artist: Toto


-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718

