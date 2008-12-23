Return-Path: <cyrus@holtmann.org>
Subject: Re: Two updated patches
From: Marcel Holtmann <marcel@holtmann.org>
To: Christian Hoene <hoene@uni-tuebingen.de>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1230048478.20536.10.camel@hoene-desktop>
References: <1230048478.20536.10.camel@hoene-desktop>
Content-Type: text/plain
Date: Wed, 24 Dec 2008 00:04:18 +0100
Message-Id: <1230073458.4954.6.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

> again. Hopefully, I got all coding style rules right this time.
> Here my two patches.

so I applied both patches, but I actually had to touch your options
patch to make it look a little bit nicer and fix some pending coding
style stuff. Don't worry, non of that is obvious. The cases where you
have too many options or statements in if/while etc. for format strings
are kind nasty. The reason for being so strict here is that the code
must remain easy readable even after years. The right and more clean
indentation is crucial here 

Also in the future please use git-format-patch so I can just commit them
directly. That way also your name shows up in the repository. And that
way you get forced to write a commit message. If I have to write the
commit message by myself, I don't bother changing the author ;)

Regards

Marcel


