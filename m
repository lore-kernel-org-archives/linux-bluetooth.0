Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/cts: Update CTS test results for Android 5.0
Date: Fri, 21 Nov 2014 09:15:10 +0100
Message-ID: <2583652.Hra3FIedfq@uw000953>
In-Reply-To: <1416235809-12637-1-git-send-email-marcin.kraglak@tieto.com>
References: <1416235809-12637-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Monday 17 of November 2014 15:50:09 Marcin Kraglak wrote:
> ---
>  android/cts.txt | 50 +++++++++++++++++++++++++-------------------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/android/cts.txt b/android/cts.txt
> index 9a7f651..68feabf 100644
> --- a/android/cts.txt
> +++ b/android/cts.txt
> @@ -1,15 +1,8 @@
>  Android Compatibility Test Suite results
>  
> -Tested: 11-July-2014
> -Android version: 4.4.4
> -CTS version: 4.4 R3
> -
> -Note:
> -CTS reliable write GATT tests require using CTS from master branch
> -or https://android-review.googlesource.com/99354 applied.
> -
> -(*) Due to bug in Bluedroid L2CAP implementation GATT server connect tests fails
> -without modified Linux kernel. Patches for Linux and/or Bluedroid are still TBD.
> +Tested: 17-November-2014
> +Android version: 5.0
> +CTS version: 5.0 r0.5
>  
>  -------------------------------------------------------------------------------
>  android.bluetooth.cts.BasicAdapterTest (automated tests)
> @@ -17,13 +10,13 @@ Test Name				Result	Notes
>  -------------------------------------------------------------------------------
>  testAndroidTestCaseSetupProperly	PASS
>  test_checkBluetoothAddress		PASS
> -test_enableDisable			PASS
> -test_getAddress				PASS
> -test_getBondedDevices			PASS
> +test_enableDisable			FAIL
> +test_getAddress				FAIL
> +test_getBondedDevices			FAIL
>  test_getDefaultAdapter			PASS
>  test_getName				PASS
>  test_getRemoteDevice			PASS
> -test_listenUsingRfcommWithServiceRecord	PASS
> +test_listenUsingRfcommWithServiceRecord	FAIL
>  -------------------------------------------------------------------------------

We now have updated SE Linux policy so those should pass now. Please retest.

>  
>  
> @@ -43,16 +36,23 @@ BLE Client Test:
>  	disconnect			PASS
>  BLE Server Test:
>  	add service			PASS
> -	connection			FAIL	(*) bluedroid issue.
> -	read characteristic request	FAIL	(*)
> -	write characteristic request	FAIL	(*)
> -	read descriptor request		FAIL	(*)
> -	write descriptor request	FAIL	(*)
> -	reliable write			FAIL	(*)
> -	disconnection			FAIL	(*)
> -Insecure Client				PASS
> -Insecure Server				PASS	Required kernel patch commit ID:
> +	connection			PASS
> +	read characteristic request	FAIL
> +	write characteristic request	FAIL
> +	read descriptor request		FAIL
> +	write descriptor request	FAIL
> +	reliable write			FAIL
> +	disconnection			FAIL
> +Insecure Client				FAIL
> +Insecure Server				FAIL	Required kernel patch commit ID:
>  						ba15a58b179ed76a7e887177f2b06de1
> -Secure Client				PASS
> -Secure Server				PASS
> +Secure Client				FAIL
> +Secure Server				FAIL
> +BLE Advertiser Test:
> +	BLE Hardware Scan Filter	FAIL
> +	BLE Tx Power Level		FAIL
> +BLE Scanner Test
> +	BLE Hardware Scan Filter	FAIL
> +	BLE Tx Power Level		FAIL
> +
>  -------------------------------------------------------------------------------
> 

-- 
Best regards, 
Szymon Janc
