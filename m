Return-Path: <cyrus@holtmann.org>
Message-ID: <4DAA27C8.7060800@gmail.com>
Date: Sat, 16 Apr 2011 16:35:36 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Gottfried Haider <gottfried.haider@gmail.com>
CC: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [Regression] Bluetooth pairing does not work anymore in 2.6.39-rc3
 (works in 2.6.38.3)
References: <BANLkTi=LvyZ+7BHfVL849pztfvsYaVM4SQ@mail.gmail.com> <4DA9CB83.4050000@gmail.com> <BANLkTi=avo9yvpQ0VRPRv1uroF3ZnJzfAg@mail.gmail.com>
In-Reply-To: <BANLkTi=avo9yvpQ0VRPRv1uroF3ZnJzfAg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 04/16/2011 03:43 PM, Gottfried Haider wrote:
> Hi Justin,
>
>> I'm wondering if you are hitting what I was hitting a few days ago.. the
>> commit below got things working over here:
>> (not sure if this is in the stable yet)
>> http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-next-2.6.git;a=commitdiff;h=b99faf1b798d6d0e33526fd2cef55a405c08ff09;hp=58b6e124aac64bebb2e9e1a136cbd21a5ab0485a
>
> I checked: I have this commit in -rc3, so it must be something else here.
>
> greetings,
>
> gohai
>

hmm... seems to be working over here with the latest Mainline. one thing 
  I have notice though is the daemon is not starting during 
boot(systemd), manually starting bluetoothd gets me to connect.(system 
is fedora 15).

Justin P. Mattock
