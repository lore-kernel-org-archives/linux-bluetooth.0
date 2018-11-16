Return-Path: <SRS0=Z/iR=N3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75193C43441
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Nov 2018 15:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD2A2089D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Nov 2018 15:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aZ69rPfQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD2A2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389942AbeKQBbC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Nov 2018 20:31:02 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:16430 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbeKQBbC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Nov 2018 20:31:02 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20181116151812epoutp013e875099f96ea962cd89445c4bc07ae2~no8ujbhoV1780717807epoutp01P
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Nov 2018 15:18:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20181116151812epoutp013e875099f96ea962cd89445c4bc07ae2~no8ujbhoV1780717807epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542381492;
        bh=xD8bb0U7f8hHXcxVm8/PuWYyhMxoV3HgbJ1zmyESJgQ=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=aZ69rPfQlpOcyHzeDfAli13ZVq72jKpvU1U+DGBS9MWXQI2D1Gh24U//g1QNyq8MU
         vf0RsaqAYyAmAbxGM7k8hKpTTcG1T7IrejgeXxnHvEDYk37gfeJnPUqPgtQU4r+iru
         Iqb9nVCmDiIPGQbYhXUo3iYCZ/LevNgHQpGrOjJQ=
Received: from epsmges5p2new.samsung.com (unknown [182.195.40.193]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20181116151809epcas5p3d59602c2a82f994af02c2e020e9b0548~no8sI1vrg2447624476epcas5p3U;
        Fri, 16 Nov 2018 15:18:09 +0000 (GMT)
X-AuditID: b6c32a4a-58fff70000000fe5-e0-5beedfb14c59
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.8B.04069.1BFDEEB5; Sat, 17 Nov 2018 00:18:09 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: Kernel interace for LE Set/Read PHY API's
Reply-To: anupam.r@samsung.com
From:   Anupam Roy <anupam.r@samsung.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        SACHIN DEV SHARMA <sachin.dev@samsung.com>,
        Anupam Roy <anupam.r@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CABBYNZ+f5nsJnqa85EBt2GDv2ZL-kE9pa5NsjuJEwjTnm=qdCA@mail.gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20181116151809epcms5p3ae8a3556d160d0b07602c93de000c8fa@epcms5p3>
Date:   Sat, 17 Nov 2018 00:18:09 +0900
X-CMS-MailID: 20181116151809epcms5p3ae8a3556d160d0b07602c93de000c8fa
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7bCmlu7G+++iDR5c17e4s9raYs61PmaL
        p5+nsFrcutHP4sDisXPWXXaPvi2rGD0+b5ILYI7KsclITUxJLVJIzUvOT8nMS7dV8g6Od443
        NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBWqakUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVK
        LUjJKTA0KtArTswtLs1L10vOz7UyNDAwMgWqTMjJmPbuNmvBVpmKiSeTGhj/i3UxcnJICJhI
        /Pp+mrmLkYtDSGA3o8SWYzuBHA4OXgFBib87hEFqhAWsJM7M284OYgsJyEksnrqWDaREWEBT
        4ubGFJAwm4C6xK+HO1hAwiIChhLfLsSATGQWmMUo8elLIxPEKl6JGe1PWSBsaYnty7cygtic
        AoESC0/fh4qLStxc/ZYdxn5/bD4jhC0i0XrvLDOELSjx4OduRpBdEgIyEvsW8oHskhDoZpRY
        fO42M4SznFHi88JjUIPMJaat7QMbxCvgK9H/4TI7SDOLgKrE6/s1ECUuEu9mNLOB2MwC8hLb
        384BhwIz0Ivrd+lDhPkken8/gXtlxzwYW0li6/X5rBC2hETf5l1QcQ+JI0+2MUNC7Q6jxIzn
        whMY5WchwnYWkmWzEJYtYGRexSiZWlCcm55abFpglJdajhyhmxjBiU3LawfjsnM+hxgFOBiV
        eHgNyt9GC7EmlhVX5h5ilOBgVhLhNZzwLlqINyWxsiq1KD++qDQntfgQoynQ1xOZpUST84FJ
        N68k3tDUyMzMwNLA1NjCzFBJnHeu7NxoIYH0xJLU7NTUgtQimD4mDk6pBsYDL+9KB2y+/7dk
        f6V1tVKByZplsXI8jRfju2/sPMLV+m/p2pKgdTNqffQ8WpkzOS12MEd8/tN+SbnC8UdI84So
        zZucw95Fts2dMU399dctjRXTLnju/xi7PZTBgXXSVPWwS0JZpZmHOrTrWf4XWHYrXfwo/uDC
        J/WIXR0zKjKeFux63nH8wG8lluKMREMt5qLiRABK7HomggMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181101075451epcms5p466176e62713906cef4d5aa41ef8cfc2e
References: <CABBYNZ+f5nsJnqa85EBt2GDv2ZL-kE9pa5NsjuJEwjTnm=qdCA@mail.gmail.com>
        <20181101075451epcms5p466176e62713906cef4d5aa41ef8cfc2e@epcms5p4>
        <CGME20181101075451epcms5p466176e62713906cef4d5aa41ef8cfc2e@epcms5p3>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>--------- Original Message ---------
>Sender : Luiz Augusto von Dentz <luiz.dentz@gmail.com>
>Date   : 2018-11-01 23:28 (GMT+9)
>Title  : Re: Kernel interace for LE Set/Read PHY API's
> 
>Hi Anupam,
>On Thu, Nov 1, 2018 at 10:26 AM Anupam Roy <anupam.r@samsung.com> wrote:
>>
>> Hi,
>>  Is there is any plan or on-going work to support kernel interface for BT 5.0 PHY based HCI commands - 'LE Set PHY', 'LE Read PHY'?
>> Actually, we would want to have support for the above, such that PHY parameters can be updated\indicated from user space BlueZ for any particular connection.
>> As I see, currently there is no kernel interface via which application can change PHY or atleast request controller to change PHY (for a particular connection)
>>
>> In order to support these via kernel interface, I think following could be possible approaches.
>>  - via kernel's MGMT interface (I am not sure if this would be ideal approach to set PHY preferrence from user space)
>>  - via L2CAP socket options (Bluez user space would be able to read\Set Preference for a particular connection handle)
>>  - via kernel internal logic (Don't expose control to user space and handle Read/Set PHY internally inside kernel. Choose 2M always, irrespective of user's preference.
>>        But, i am not sure, if this would conflict with different application's requirement for a particular PHY.
> 
>I think it might be better to have a QoS option per socket since it
>probably need to accessible at application level, that way the
>application can configure its preference which may or may not be
>attended in case there are more channels, for instance if app A
>request 1Mbit/s and app B request 2Mbit/s than we probably should go
>with 2Mbit/s but this is a policy that could probably go into the
>kernel directly. This could also be extended to connection parameters
>as well, in fact I think we would benefit more from starting with
>connection parameters and then add PHY field later on.
>
Thank you providing your suggestions and sory for delay in response. By extending to connection parameters, if you are suggesting that we can introduce l2cap socket options for configuring LE connection parameters, I think it will
be ofcourse a good option for user/app for configuring params, based on its specific needs.
Handling LE connection parameter update alone seems OK to handle inside kernel based on some conditions.
However, in this context, I am wondering if later on, if we add PHY fields to the same socket option, do we need to consider following for handing the mixed (PHY params + Conn params) options via L2CAP socket? 
   - Whether to go for Connection parameter update procedure (based on connection parameters and other requirements) or go for LE Set PHY (based on PHY fields suggested by user)
   - Or handle both in some sequence
 Basically in order to resolve this, I think some further policy need to be defined inside kernel? Please provide some insights. Thank You!
 
>> Also please suggest if there is any other better way to support these?
>>
>> Why we would require these support?:  Even though LE Set Default PHY can be used to indicate controller about preferrence/mix of certain PHY's, it will be applied (unless controller denies it based on Connection interval or other requirements)
>> for all subsequent connections and hence no per connection(application) control over PHY.
>>
>> Please provide your suggestions/comments on how to go about with these!
>> Thank You very much!
>>
>> BR,
>> -Anupam Roy
> 
> 
> 
>-- 
>Luiz Augusto von Dentz

BR,
-Anupam Roy
