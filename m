Return-Path: <cyrus@holtmann.org>
Cc: Thierry Pierret <extern.Thierry.Pierret@awtce.be>
Message-Id: <FD63ABCF-8F3A-409E-AEBE-47EC4A296D51@tiscali.it>
From: Michele Noberasco <michele.noberasco@tiscali.it>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <OF066E85D2.BE4D0799-ONC125755C.002E8D45-C125755C.00306BFF@aweurope.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 0/4] HFP Gateway profile
Date: Fri, 13 Feb 2009 10:00:11 +0100
References: <OF066E85D2.BE4D0799-ONC125755C.002E8D45-C125755C.00306BFF@aweurope.be>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Il giorno 13/feb/09, alle ore 09:48, Thierry Pierret ha scritto:

> 2°/ As soon as the mobile is paired and the "Handsfree" service is
> connected, the mobiledirectly disconnects. I cannot see in the logs  
> what's
> wrong.

I experienced this issue myself when I tried to implement the same  
functionality. I didn't get so far as to address it, but in my case  
the issue could be work-arounded (only for tests of course, a proper  
fix would be needed before a release anyway) by having the device  
receive a phone call during (or immadiately after) connection. In this  
case, it will stay connected at least for the duration of the call.

Regards,
Michele Noberasco

