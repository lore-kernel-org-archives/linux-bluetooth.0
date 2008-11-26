Return-Path: <cyrus@holtmann.org>
Message-Id: <AC5DBAC4-3D07-4F81-A147-FECD9DB91B78@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <492D1F90.9070706@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: HBH-PV270 headset get locked
Date: Wed, 26 Nov 2008 15:05:22 +0200
References: <492B7A98.90603@gmail.com> <492BB3F2.3050005@gmail.com>	 <C2133416-B233-4FFF-B29B-0BCF3B3402E1@gmail.com> <2d5a2c100811250634vd53daafvce6791992a3c621@mail.gmail.com> <492D1F90.9070706@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Nov 26, 2008, at 12:06, Sam Lin wrote:

> 1. so do you suggest to just remove the client->dev = NULL statement  
> in headset_setup_complete() and headset_resume_complete() ?

There were already fixes pushed to the git for this. Please test them  
and let us know if they help.

Johan
