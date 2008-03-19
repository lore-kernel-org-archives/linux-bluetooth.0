Return-Path: <cyrus@holtmann.org>
Message-Id: <A6B7F17C-B7E5-4A45-8208-D9C1FBC68C96@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: =?EUC-KR?B?wMzB1r+1?= <tkakel@naver.com>,
	BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1e720e88bd7ce5a74be321703f24060d@i61813>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Wed, 19 Mar 2008 17:47:11 +0100
References: <1e720e88bd7ce5a74be321703f24060d@i61813>
Subject: Re: [Bluez-devel] I've found a bug in sdp_cstate_get() function.
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

> I've found a bug in sdp_cstate_get() function.
> (bluez-utils/dist/sdpd/request.c)
>  -> memcpy(cstate, (sdp_cont_state_t *)pdata,  
> sizeof(sdp_cont_state_t));
> When running this code, "hcid daemon crash" occurred.(memory  
> alignment error)
>
> I think there's a bug with (sdp_cont_state_t *)pdata in  
> sdp_cstate_get() function.
> I fixed this code.
>  -> memcpy(cstate, pdata, sizeof(sdp_cont_state_t));
> Now, hcid daemon doesn't die.
>

which version? This should have been fixed by now. Either in the  
latest bluez-utils-3.28 or the CVS.

Regards

Marcel


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
