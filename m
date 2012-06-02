Return-Path: <cyrus@holtmann.org>
Date: Sat, 2 Jun 2012 09:09:39 +0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel Wagner <wagi@monom.org>
Cc: linux-bluetooth@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: [PATCH v3 00/14] Prefer PAN over DUN
Message-ID: <20120602010939.GA22641@x220.docomointertouch.net>
References: <1338471818-20894-1-git-send-email-wagi@monom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338471818-20894-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Thu, May 31, 2012, Daniel Wagner wrote:
> From: Daniel Wagner <daniel.wagner@bmw-carit.de>
> 
> Hi,
> 
> This version moves the UUID strings into the lib instead of the core.
> I tried to do get rid of the UUID string using the *_SVCLASS_ID from sdp.h
> but it is hard to do string magic during precompile time...
> 
> cheers,
> daniel
> 
> changes:
> 
> v3: - Move UUID strings into lib
> 
> v2: - Move all UUID string definition into one header file
>     - Change configuration variable name
>     - This behavior is off by default
> 
> Daniel Wagner (14):
>   sdp: Remove unused BASE_UUID definition
>   audio: Move UUID string definition to lib
>   network: Move UUID string definition to lib
>   deviceinfo: Move UUID string definition to lib
>   proximity: Move UUID string definition to lib
>   sap: Move UUID string definition to lib
>   thermometer: Move UUID string definition to lib
>   serial: Move UUID string definition to lib
>   health: Move UUID string definition to lib
>   input: Move UUID string definition to lib
>   pnat: Move UUID string definition to lib
>   core: Move UUID string definition to lib
>   main: Add PreferPANoverDUN configuration switch
>   device: Ignore DUN if PAN is present

I've applied patches 1-12 but I stopped there for now since I'm not
completely convinced of the config file parameter naming.

Johan
