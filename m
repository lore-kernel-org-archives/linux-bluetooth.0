Return-Path: <SRS0=LC31=TQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8478DC04AB4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 May 2019 06:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00598206BF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 May 2019 06:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=phytec.in header.i=@phytec.in header.b="BmH8OIYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfEPGMW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 May 2019 02:12:22 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:42240 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfEPGMV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 May 2019 02:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.in; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.in; t=1557987140; x=1560579140;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=of6Vlu6R7se5bXwH8Lq26p6g21MAQIYYx8y3y/M9IkI=;
        b=BmH8OIYHvSa0L1MQQn25BrD331spBlrI1OeLFhrqgzvpHl8IJPxz9KPuyIKbIVnt
        K+94WS7ngEDZp6X5NG9GkyatHWCxMcbEGnGR3vj65m3kbMvD+1u7oaW+ferBeKBG
        vy44v7eYIi93D8Za+8YNb0yEcSvYoluc/SL4FhMUUfc=;
X-AuditID: c39127d2-6bdff70000000df6-48-5cdcff443c2f
Received: from tumirnix.phytec.de (tumirnix.phytec.de [172.16.0.38])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 59.E5.03574.44FFCDC5; Thu, 16 May 2019 08:12:20 +0200 (CEST)
Received: from [192.168.1.15] ([106.51.130.232])
          by tumirnix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2019051608120639-8 ;
          Thu, 16 May 2019 08:12:06 +0200 
Subject: Re: Issue with mesh provisioning.
To:     Steve Brown <sbrown@ewol.com>,
        "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Jonas Remmert <j.remmert@phytec.de>
References: <33a1f056-12c2-1aaa-4172-ea1fba341428@phytec.in>
 <a133a8d46955c9c3d248cf06e52d445a82ed7621.camel@ewol.com>
 <0ec70f654132923489ee2603fe9ac885ac547830.camel@ewol.com>
 <CACumGOKJckqHDsB==1MwNFOtZVtduRPZhTmtbQT-fTaztuv+dQ@mail.gmail.com>
 <4fa544fa04d907de54ab713eb0d0901593d2687e.camel@ewol.com>
From:   Shaik Mahaboob Nazeer <nazeer.m@phytec.in>
Message-ID: <c39d487d-7e7f-b4d2-17a8-fe8e9d293159@phytec.in>
Date:   Thu, 16 May 2019 11:42:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4fa544fa04d907de54ab713eb0d0901593d2687e.camel@ewol.com>
X-MIMETrack: Itemize by SMTP Server on Tumirnix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 16.05.2019 08:12:06,
        Serialize by Router on Tumirnix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 16.05.2019 08:12:06,
        Serialize complete at 16.05.2019 08:12:06
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWyRoBBTdfl/50Yg3V/RS3mXOtjtpjwo5nF
        4uLPo2wOzB6/e+aweize85LJ4/MmuQDmKC6blNSczLLUIn27BK6MWW/PMRUsl6r4unMZawPj
        CZEuRg4OCQETicbtll2MXBxCAnsYJQ7f2MgO4ZxklHh4cS1LFyMnh7CAlsTJXa9YQWwRAX+J
        M89Ps4HYzAIeEsd3zWSDaNjOJLH4egdYgk3AQGLrrIPsIDavgI3E0SVtYM0sAqoS2769ZgKx
        RQUiJM68X8ECUSMocXLmEzCbU8BN4ue9m2A1EgKtTBI798dC2EISpxefZYZYLC+x/e0cKFtd
        4s+8S1C2uMStJ/OZJjAKzUIydhaSlllIWmYhaVnAyLKKUSg3Mzk7tSgzW68go7IkNVkvJXUT
        IzDYD09Uv7SDsW+OxyFGAQ5GJR7eib9uxwixJpYVV+YeYpTgYFYS4d3wHijEm5JYWZValB9f
        VJqTWnyIUZqDRUmcdwNvSZiQQHpiSWp2ampBahFMlomDU6qBke32iW7VM2V8VRtaJ63d/Cel
        KGXH45f31N+ybjhj/tBjCpeaMLf2zv+30ucm+qnVy0Xelph9IJSzaMvF1ZPd3ebpatv881q2
        KuDtLPeURPbFq+05/FSu/L6zOWplZcn71r0fDwX0cp1e90rj96P71p/Dr+yeM6v3d6nmvm8v
        9xVOiD1RaTSZuU2JpTgj0VCLuag4EQBLWFSPcgIAAA==
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

hi Steve,

Yes with this changes it is working as expected. 

Best Regards.

On 15/05/19 17:42, Steve Brown wrote:
> Hi Luiz,
> 
> Would this be an appropriate fix.
> 
> It seems to solve the problem.
> 
> diff --git a/tools/mesh/gatt.c b/tools/mesh/gatt.c
> index 2269a20cf..0a942d4eb 100644
> --- a/tools/mesh/gatt.c
> +++ b/tools/mesh/gatt.c
> @@ -415,8 +415,11 @@ static bool sock_read(struct io *io, bool prov, void *user_data)
>  	msg.msg_iovlen = 1;
>  
>  	while ((len = recvmsg(fd, &msg, MSG_DONTWAIT))) {
> -		if (len <= 0)
> +		if (len <= 0) {
> +			if (errno == EAGAIN)
> +				break;
>  			return false;
> +		}
>  
>  		res = buf;
>  		len_sar = mesh_gatt_sar(&res, len);
> 
> If so, I'll submit a patch.
> 
> Steve
> 
> On Wed, 2019-05-15 at 13:48 +0300, Von Dentz, Luiz wrote:
>> Hi Steve,
>>
>> That specific patch doesn't change the meshctl, the following one
>> does:
>>
>> commit d6eec1b67d6d9e3336b7e3cd8f655baf408d864a
>> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> Date:   Mon Nov 19 17:35:54 2018 +0200
>>
>>     meshctl: Switch from write to sendmsg for Acquire*
>>
>>     Use sendmsg with MSG_NOSIGNAL to prevent crashes involving
>> SIGPIPE.
>>
>> Not sure what is the problem with that since we just switch from a
>> pipe to a socketpair.
>>
>> On Wed, May 15, 2019 at 1:01 PM Steve Brown <sbrown@ewol.com> wrote:
>>> On Tue, 2019-05-14 at 15:25 -0400, Steve Brown wrote:
>>>> On Tue, 2019-05-14 at 14:50 +0530, Shaik Mahaboob Nazeer wrote:
>>>>> hi,
>>>>>
>>>>> -> We tried Zephyr Mesh onoff example on nrf52 eval kit to test
>>>>> the
>>>>> Mesh Functionality.For provisioning of the node
>>>>>    we are using meshctl, built from the latest current master
>>>>> of
>>>>> the
>>>>> bluez source.So during the provisioning of the node when we
>>>>>    start the "meshctl" and run the "discover-unprovisioned on"
>>>>> we
>>>>> are
>>>>> able to get the Device UUID for the provisioning.
>>>>>
>>>>>    Later when we try to provision the node using the "provision
>>>>> <UUID>" command it initiate the provision and does not wait
>>>>>    for the user to enter OOB .You can find the log as below.
>>>>>    /*******************************************/
>>>>>
>>>>
>>>> --- snip ---
>>>>
>>>>>   /**************************************/
>>>>>
>>>>> Could you elaborate a little on the status of the current
>>>>> master of
>>>>> bluez in regards to BLE mesh, is it usable or should we look to
>>>>> older
>>>>> versions?
>>>>>
>>>>> Do you know if there is a common issue while provisioning of
>>>>> the
>>>>> node
>>>>> with the current master and
>>>>> is there anything that need to be configured before
>>>>> provisioning?
>>>>>
>>>> I get the same results.
>>>>
>>>> I check out 48a2c3db1ccff28a615fac56066ca7d721f98d0a
>>>>
>>>> That was the last time I used meshctl.
>>>>
>>>> It requests an oob string and completes provisioning.
>>>>
>>>> Steve
>>>>
>>>
>>> I bisected to
>>>
>>> commit 91df85690cc1943e46ef90561dd1ac0d673ee3d7
>>> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>> Date:   Mon Nov 19 15:36:15 2018 +0200
>>>
>>>     client: Switch from write to sendmsg for Acquire*
>>>
>>>     Use sendmsg with MSG_NOSIGNAL to prevent crashes involving
>>> SIGPIPE.
>>>
>>>
>>>
> 
 

