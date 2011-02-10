Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110209212642.GA11368@jh-x301>
References: <1297179136-14750-1-git-send-email-sheldon.demario@openbossa.org>
	<1297179136-14750-3-git-send-email-sheldon.demario@openbossa.org>
	<20110209212642.GA11368@jh-x301>
Date: Thu, 10 Feb 2011 14:14:33 -0300
Message-ID: <AANLkTin=2-k7F7DUO8rvzLJgf-m7+wUQ7FgtUR5ivuMu@mail.gmail.com>
Subject: Re: [PATCH 3/5] Add an initial interactive mode to gatttool
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: Sheldon Demario <sheldon.demario@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>> +static void cmd_help(int argcp, char **argvp);
>> +static void cmd_exit(int argcp, char **argvp);
>
> No forward-declarations please. Just reorder the functions so that you
> don't need to do this.

The problem is the cmd_help() function. It must be declared to be
known by commands[] array.
The commands[] array also must be known by cmd_help(), so what do you
suggest to solve this?

Sheldon

>
> Johan
>
