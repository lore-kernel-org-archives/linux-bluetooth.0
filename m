Return-Path: <cyrus@holtmann.org>
Message-Id: <25F32EEE-D3D4-473F-8B8D-7447B2C024B5@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <11f7a7550901120618r84faa0dwd1e1234bc3dfe63@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: Inconsistencies with UUIDs in XML service descriptors
Date: Mon, 12 Jan 2009 15:32:33 +0100
References: <11f7a7550901090850x4c276806v6c3c4bfad804986f@mail.gmail.com> <11f7a7550901090852s30060e38g7c9240731d3a9a4f@mail.gmail.com> <11f7a7550901100402o790bd614ud46a613e2dce1dbd@mail.gmail.com> <20090110124119.GA20941@localhost> <11f7a7550901120618r84faa0dwd1e1234bc3dfe63@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniele,

On Jan 12, 2009, at 15:18, Daniele Benucci wrote:
> 2009/1/10 Johan Hedberg <johan.hedberg@nokia.com>:
>> Could you perhaps try to use git bisect
>> to determine the exact patch that causes the bug?
>
> According to git-bisect commit introducing the bug is
>
> 204180c7dc2e20b9b701275a3fefb52707720f54
>
> (Make use of sdp_copy_record.)

Thanks a lot! This will really help in investigating and fixing the  
issue. We'll most likely have it fixed for the next BlueZ release  
(Luiz, who authored the sdp_copy_record function, is now looking into  
it).

Johan
