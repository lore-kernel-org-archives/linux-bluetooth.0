Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Change LE advertising interval via D-Bus API
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20160811052332.GA27638@t440s.P-661HNU-F1>
Date: Thu, 11 Aug 2016 08:48:36 +0200
Cc: Alex Coplan <alex.coplan@starleaf.com>,
	linux-bluetooth@vger.kernel.org, rdl@starleaf.com
Message-Id: <FDC96232-A28E-4810-A943-84E5987AE1B4@holtmann.org>
References: <1DAD8581-6B6C-4973-A284-C8B1F210C4AD@starleaf.com> <14FF3F29-1C6E-41F9-B41D-850772B758B3@holtmann.org> <FB35544E-8D8B-48B1-825A-E0A5BC8D92C3@starleaf.com> <581A4CCB-9778-4C48-9075-7CFCC1C95884@holtmann.org> <E954B4D5-5952-4935-8B8D-D618C7C693DC@starleaf.com> <4ADDE98F-C561-415B-AFA7-D407B21EFFCD@holtmann.org> <13AF5DC1-C9E7-4EB0-A1DA-F63ACB63F614@starleaf.com> <20160811052332.GA27638@t440s.P-661HNU-F1>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

>> In principle, I would be happy to do this. However, I am currently
>> experiencing issues with the management interface that would be
>> prohibitive to working on it. In particular, running tools/mgmt-tester
>> results in three tests failing:
>> - Set Powered On - Privacy and Advertising
>> - Add UUID - UUID-16 partial 1
>> - Remove Device - Success 3
>> 
>> I am particularly concerned about the first test regarding privacy and
>> advertising.
> 
> The only kernel mgmt-tester tests are intended to pass with is
> bluetooth-next. This is because tests are often added when bugs are
> found & fixed, and this means it takes some time for the fix to make it
> to a mainline release. That said, we haven't lately had major
> changes/fixes to the mgmt interface on the kernel side, but e.g. 4.4 may
> very well be old enough that not all tests pass with it.

I might add that you can run this Qemu/KVM to test the latest kernel:

	./tools/test-runner -- ./tools/mgmt-tester -q

	Total: 307, Passed: 307 (100.0%), Failed: 0, Not Run: 0
	Overall execution time: 24.9 seconds

And there is a doc/test-runner.txt that describes on how to build a kernel for this magic testing tool.

Regards

Marcel

