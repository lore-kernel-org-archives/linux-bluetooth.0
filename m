Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 1/2] android: Add skeleton of BlueZ Android daemon
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20130924073124.GA26962@aemeltch-MOBL1>
Date: Fri, 27 Sep 2013 03:56:14 +0200
Cc: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>,
	Frederic Danis <frederic.danis@linux.intel.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <188944FA-9CB2-433B-A3D2-D706DBD6E1BD@holtmann.org>
References: <1379679871-29623-1-git-send-email-frederic.danis@linux.intel.com> <226042C8-264A-469E-8D6A-F41141DC0552@holtmann.org> <52400F2B.9010501@linux.intel.com> <CAN_7+YYSLwsPTfJoYwJKcVtP6EMxOeD8MHox+Pvzcrk_YKcSaQ@mail.gmail.com> <20130924073124.GA26962@aemeltch-MOBL1>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

>>>>> Define local mapping to glib path, otherwise this has to be inside
>>>>> central
>>>>> place in the build repository.
>>>>> 
>>>>> Retrieve Bluetooth version from configure.ac.
>>>>> ---
>>>>> .gitignore         |    2 +
>>>>> Android.mk         |    9 ++++
>>>>> Makefile.am        |    1 +
>>>>> Makefile.android   |    7 ++++
>>>>> android/Android.mk |   24 +++++++++++
>>>>> android/main.c     |  119
>>>>> ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>> configure.ac       |    5 +++
>>>>> 7 files changed, 167 insertions(+)
>>>>> create mode 100644 Android.mk
>>>>> create mode 100644 Makefile.android
>>>>> create mode 100644 android/Android.mk
>>>>> create mode 100644 android/main.c
>>>> 
>>>> 
>>>> lets split this out a little bit. Code additions should not be intermixed
>>>> with additions to the build system and especially configure options.
>>>> 
>>>> I rather not have a top-level Android.mk. It should be enough to provide
>>>> an android/Android.mk.
>> 
>> BTW, do you expect to have only one Android.mk for the whole project or
>> this is OK for you to have smaller Android.mk in different subfolders like
>> /src/shared etc. Both ways are valid.
> 
> While having a single huge Android makefile is somehow make sense it would have
> several disadvantages:
> - we cannot use local build with "mm" for building for example only tools
>  or libs
> - Android.mk will become very large and difficult to read

I have no idea what this means. Lets start with a single android/Android.mk and then go from there. I am strictly against cluttering the whole project with Android specific make files.

Regards

Marcel

