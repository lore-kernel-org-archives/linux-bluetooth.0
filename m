Return-Path: <cyrus@holtmann.org>
Cc: "Odysseus Flappington" <deriziotis@gmail.com>,
	"BlueZ users" <bluez-users@lists.sourceforge.net>,
	linux-bluetooth@vger.kernel.org
Message-Id: <9CBA2065-DBBE-4342-BF35-2C24BDF829C5@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Dave Young <hidave.darkstar@gmail.com>
In-Reply-To: <a8e1da0803211729l1fdfeeb5ie22c70652bc1e76a@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [Bluez-users] hciconfig hci0 reset bug
Date: Wed, 26 Mar 2008 17:22:14 +0100
References: <5eee8c670802281451i392c0debq7a16286d76d33bfb@mail.gmail.com> <a8e1da0803021721m3145bc7fpd896760d4bed7d97@mail.gmail.com> <a8e1da0803021724h654f65ceif24b2035dc94a5ec@mail.gmail.com> <5eee8c670803030335v49536053j136b8b46addb8129@mail.gmail.com> <5eee8c670803031419k10c8e625p447f8f98ac27dcb9@mail.gmail.com> <5eee8c670803170528o44384744pe238c378953dbc02@mail.gmail.com> <a8e1da0803180014u262a7ee0h25ff58a0e6363dfd@mail.gmail.com> <5eee8c670803201019q4703c779wbb597b806cf4d7c@mail.gmail.com> <a8e1da0803211729l1fdfeeb5ie22c70652bc1e76a@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dave,

>> I've been looking around to see if I could figure out the build id  
>> where the
>> dongles started shipping with the correct HCI_Reset. I think I may  
>> have
>> found something.
>
> Thanks a lot.
>
> Marcel, I think it's what you want.  I would like to file a patch.

yes, but I already got it via CSR internals. They have always been  
helpful when it comes to BlueZ. CSR is an open source friendly  
company. I didn't have time to actually produce that patch since we  
have to turn the whole logic around.

Regards

Marcel

