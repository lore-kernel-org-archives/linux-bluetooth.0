Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20090110124119.GA20941@localhost>
References: <11f7a7550901090850x4c276806v6c3c4bfad804986f@mail.gmail.com>
	 <11f7a7550901090852s30060e38g7c9240731d3a9a4f@mail.gmail.com>
	 <11f7a7550901100402o790bd614ud46a613e2dce1dbd@mail.gmail.com>
	 <20090110124119.GA20941@localhost>
Date: Mon, 12 Jan 2009 15:18:55 +0100
Message-ID: <11f7a7550901120618r84faa0dwd1e1234bc3dfe63@mail.gmail.com>
Subject: Re: Inconsistencies with UUIDs in XML service descriptors
From: Daniele Benucci <d.benux@gmail.com>
To: Johan Hedberg <johan.hedberg@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2009/1/10 Johan Hedberg <johan.hedberg@nokia.com>:
> Could you perhaps try to use git bisect
> to determine the exact patch that causes the bug?

According to git-bisect commit introducing the bug is

204180c7dc2e20b9b701275a3fefb52707720f54

(Make use of sdp_copy_record.)

Regards

Daniele.

-- 
Grabel's Law:
2 is not equal to 3 -- not even for large values of 2.
