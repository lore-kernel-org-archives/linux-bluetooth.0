Return-Path: <SRS0=WtLI=WK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB27C433FF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Aug 2019 21:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA73208C2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Aug 2019 21:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbfHNVCS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Aug 2019 17:02:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:44523 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729434AbfHNVCS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Aug 2019 17:02:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 14:02:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,386,1559545200"; 
   d="scan'208";a="176685276"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga008.fm.intel.com with ESMTP; 14 Aug 2019 14:02:15 -0700
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 14 Aug 2019 14:02:15 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.157]) by
 ORSMSX113.amr.corp.intel.com ([169.254.9.128]) with mapi id 14.03.0439.000;
 Wed, 14 Aug 2019 14:02:14 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
CC:     "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 0/1] mesh: Add D-Bus Security for sensitive data
Thread-Topic: [PATCH BlueZ 0/1] mesh: Add D-Bus Security for sensitive data
Thread-Index: AQHVUkHFvJ8+Ufu0XkWdTJqFRbJnc6b6uyMAgACUCICAAEYpAP//jUFf
Date:   Wed, 14 Aug 2019 21:02:14 +0000
Message-ID: <FF0F331A-753C-4A3E-9EFD-E54BD0657DA8@intel.com>
References: <20190814014357.32453-1-brian.gix@intel.com>
 <20190814075200.j3jmxpto7kszjjkp@mlowasrzechonek2133>
 <dbffabec9a869204b4de1aab645fd727949e655e.camel@intel.com>,<20190814205256.xkuqo4zqyl63erhc@kynes>
In-Reply-To: <20190814205256.xkuqo4zqyl63erhc@kynes>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Micha³ 

> On Aug 14, 2019, at 1:53 PM, "michal.lowas-rzechonek@silvair.com" <michal.lowas-rzechonek@silvair.com> wrote:
> 
> Hi Brian,
> 
>> On 08/14, Gix, Brian wrote:
>> I would like Marcel to weigh in on this since the security of exposing
>> keys via D-Bus was initially a concern raised by him.
> Ok.
> 
>> Also, we may be able to leave it in the hands of the Application that
>> owns the node.  It could be as simple as the Application decides to
>> secure the D-Bus channel (for only itself) by performing the Public
>> Key Exchange.
> For the record - I understand the hesitation to "trust" the applications
> to correctly handle security and I don't mean to dispute this. I
> understand that once keys are exfiltrated from a network, all hell
> might break loose.
> 
> Leaking meshd's tokens does not lead to that situation - at worst, one
> could impersonate a single node.

I don't think so.... If a token is leaked, and we offer *any* kind of mechanism to export keys, then any permissions that the App with legitimate access to the token has, is then conferred on *any* entity that obtains access to the token.  

The only way around this is to not allow any access, by any apps, to any exportable keys....   or to secure access to the token.


> 
> I also agree that key export is sensitive and accesing these should
> require some kind of authorization scheme.
> 
>> If the Application does *not* request a Public Key from the Daemon,
>> and/or does not supply a Public Key during Attach/Join/Import, then
>> the APIs work the same as they do today (albeit with extra ignored
>> parameter(s)).
> This sounds complex.
> 
> Stefan raised a point about app and net keys being visible in plaintext
> when application attempts to configure a node (both local and remote).
> 
> This might lead to adding encryption to mesh payloads exchanged between
> the daemon and the application. Such a thing would IMO defeat the whole
> idea of mesh stack implemented as a system service - it would be easier
> to implement this behaviour as a library and do all the crypto on the
> application side.
> 
>> An app that knows it is opperating in a secure environment can then
>> trust the system to provide all needed security, but if for instance,
>> some sort of hybrid D-Bus that has an insecure link in the chain, thwe
>> App can add the Public Key exchange and encrypt/decrypt as needed.
> As far as I know, there are only a handful of D-Bus daemon
> implementations out there, and I don't think that any of them is
> inherently insecure. Sure, there might be bugs and vulnerabilities, but
> I am not aware of any implementation that includes an "insecure link".
> 
> Please keep in mind that D-Bus is confined within a single machine -
> yes, there is a TCP transport, but virtually all setups have this turned
> off, and IIRC freedeskop.org explicitly states that this feature should
> not be used in a production environment.
> 
> regards
> -- 
> Micha³ Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
> Silvair http://silvair.com
> Jasnogórska 44, 31-358 Krakow, POLAND
