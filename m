Return-Path: <johan.hedberg@gmail.com>
Date: Thu, 11 Aug 2016 08:23:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alex Coplan <alex.coplan@starleaf.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	rdl@starleaf.com
Subject: Re: Change LE advertising interval via D-Bus API
Message-ID: <20160811052332.GA27638@t440s.P-661HNU-F1>
References: <1DAD8581-6B6C-4973-A284-C8B1F210C4AD@starleaf.com>
 <14FF3F29-1C6E-41F9-B41D-850772B758B3@holtmann.org>
 <FB35544E-8D8B-48B1-825A-E0A5BC8D92C3@starleaf.com>
 <581A4CCB-9778-4C48-9075-7CFCC1C95884@holtmann.org>
 <E954B4D5-5952-4935-8B8D-D618C7C693DC@starleaf.com>
 <4ADDE98F-C561-415B-AFA7-D407B21EFFCD@holtmann.org>
 <13AF5DC1-C9E7-4EB0-A1DA-F63ACB63F614@starleaf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <13AF5DC1-C9E7-4EB0-A1DA-F63ACB63F614@starleaf.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Wed, Aug 10, 2016, Alex Coplan wrote:
> In principle, I would be happy to do this. However, I am currently
> experiencing issues with the management interface that would be
> prohibitive to working on it. In particular, running tools/mgmt-tester
> results in three tests failing:
>  - Set Powered On - Privacy and Advertising
>  - Add UUID - UUID-16 partial 1
>  - Remove Device - Success 3
> 
> I am particularly concerned about the first test regarding privacy and
> advertising.

The only kernel mgmt-tester tests are intended to pass with is
bluetooth-next. This is because tests are often added when bugs are
found & fixed, and this means it takes some time for the fix to make it
to a mainline release. That said, we haven't lately had major
changes/fixes to the mgmt interface on the kernel side, but e.g. 4.4 may
very well be old enough that not all tests pass with it.

Johan
