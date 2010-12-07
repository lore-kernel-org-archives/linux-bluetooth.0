Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=_1qAiH9o_4eBy66OQ9=ba=4GuatVBVtcJG5=x@mail.gmail.com>
References: <AANLkTikzecKtx3ib-03n3f8_2u4KF0Y+PSmEJgccEg-i@mail.gmail.com>
	<AANLkTi=_1qAiH9o_4eBy66OQ9=ba=4GuatVBVtcJG5=x@mail.gmail.com>
Date: Tue, 7 Dec 2010 14:22:47 +0530
Message-ID: <AANLkTin+K_AYeF9+t0qWWFRJrW5uv9OM4DGY8a2Aaaek@mail.gmail.com>
Subject: Re: [RFC] AVRCP 1.4 : Design proposal for future on Target Role
From: Shivendra Agrawal <ag.shivendra@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> I guess for all people that are interested in AVRCP 1.4 we can start
> adding items to TODO list, to make it easier to share development
> between us. Since this may be too much to handle in a single global
> TODO maybe we can have a separated file like audio/TODO.
>
Somehow I was unable to send the file with TODO list for AVRCP 1.4
So I have copied here for initial feedback from all.
If this needs any modifications please let me know and I would come
back with updates asap.

Background
==========

- Priority scale: High, Medium and Low

- Complexity scale: C1, C2, C4 and C8.  The complexity scale is exponential,
  with complexity 1 being the lowest complexity.  Complexity is a function
  of both task 'complexity' and task 'scope'.

  The general rule of thumb is that a complexity 1 task should take 1-2 weeks
  for a person very familiar with BlueZ codebase.  Higher complexity tasks
  require more time and have higher uncertainty.

  Higher complexity tasks should be refined into several lower complexity tasks
  once the task is better understood.

AVRCP 1.4
==========

- Add SDP record for AVRCP 1.4 to inform CT of the version and features
  supported by target.

  Priority: Medium
  Complexity: C1

- Add callback to accept browsing channel establishment.

  Priority: Medium
  Complexity: C1

- Enhancing bt_io_listen for browsing PSM

  Priority: Medium
  Complexity: C2

- Features to be added

	All below mentioned features will have
		Priority: Medium
		Complexity: C2

		As per spec section 6.4.1     GetCapabilities
		As per spec section 6.5.1     ListPlayerApplicationSettingAttributes
		As per spec section 6.5.2     ListPlayerApplicationSettingValues
		As per spec section 6.5.3     GetCurrentPlayerApplicationSettingValue
		As per spec section 6.5.4     SetPlayerApplicationSettingValue
		As per spec section 6.5.5     GetPlayerApplicationSettingAttributeText
		As per spec section 6.5.6     GetPlayerApplicationSettingValueText
		As per spec section 6.5.7     InformDisplayableCharacterSet
		As per spec section 6.5.8     InformBatteryStatusOfCT
		As per spec section 6.6.1     GetElementAttributes
		As per spec section 6.7.1     GetPlayStatus
		As per spec section 6.7.2     RegisterNotification
		As per spec section 6.8.1     RequestContinuingResponse
		As per spec section 6.8.2     AbortContinuingResponse
		As per spec section 6.9.1     SetAddressedPlayer
		As per spec section 6.9.2     Addressed Player Changed Notification
		As per spec section 6.9.3     SetBrowsedPlayer
		As per spec section 6.9.4     Available Players Changed Notification
		As per spec section 6.9.5     Notify Now Playing Content Changed
		As per spec section 6.10.3.3    UIDs Changed Notification
		As per spec section 6.10.4.1    ChangePath
		As per spec section 6.10.4.2    GetFolderItems
		As per spec section 6.10.4.3    GetItemAttributes
		As per spec section 6.12.1      PlayItem
		As per spec section 6.13.1      Absolute Volume
		As per spec section 6.13.3      Notify volume change
