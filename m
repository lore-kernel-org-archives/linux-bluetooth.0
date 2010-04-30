Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<jcaden@libresoft.es>
Reply-To: jcaden@libresoft.es
To: Elvis =?iso-8859-1?q?Pf=FCtzenreuter?= <epx@signove.com>
Subject: Re: More about proposed Health Device Profile API
Date: Fri, 30 Apr 2010 12:59:45 +0200
Cc: linux-bluetooth@vger.kernel.org, claudio.takahasi@openbossa.org,
	scarot <scarot@llibresoft.es>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	raul.herbster@signove.com,
	Pedro de las Heras =?iso-8859-1?q?Quir=F3s?=
	<pheras@gsyc.es>
References: <8FDD2957-B97E-4646-B164-4B00E7910399@signove.com>
In-Reply-To: <8FDD2957-B97E-4646-B164-4B00E7910399@signove.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201004301259.45561.jcaden@libresoft.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

El Friday 30 April 2010 04:28:45 Elvis Pfützenreuter escribió:
> A very simple session graph that illustrates the proposed API can be seen
>  at http://epx.com.br/health_bluez.png.
> 
> This API proposal was discussed jointly with Claudio Takahashi, Vinicius
>  Gomes, Raul Herbster and others, and it is based on previous work on MCAP
>  API specification by Jose Cadenas and Santiago Nemesio, which have been
>  CCed.

That sounds great. We are happy that our ideas are good for you. We spent a 
lot of time on its desing. If you wish, we can have a meeting early next week 
via IRC or any other way in order to disscuss this api. We have already begun 
working in HDP so it will be very interesting to discuss this API with you. We 
have a quite mature implementation of MCAP. As you know, at the current moment 
we are having an internal reorganiation so we have publish an alternative git 
with the last mcap code (still working on it). Please, feel free to download 
and test it. All comments are wellcome.

git://193.147.51.48/git/mcap_devel.git

If you are interesting in the meeting please consider that in Madrid monday is 
holiday, so the first day that we can talk to you is Tuesday 4th.

> 
> The main guidelines of our current proposal are:
> 
> a) MCAP is just a protocol, which does not specify SDP records for its own
>  needs. The HDP profile specifies the necessary SDP record, so we expose an
>  API for HDP, not for MCAP.
> 
> b) Avoid exposing MCAP protocol details to the API client, except where
>  unavoidable. Several MCAP parameters like PSM control channel may be left
>  undefined by the client, and the implementation would fill them with
>  reasonable values.
> 
> c) MCAP control connection (MCL) is completely taken care of. The
>  application only deals with MCAP data channels (MDLs), if any.
> 
> d) The application should not need to handle SDP records, which are quite
>  complicated in the HDP case. When it registers a HDP role, enough
>  information is passed so a SDP record may be published automatically.
> 
> When a remote HDP device is present, its SDP record would be interpreted
>  automatically, so the application can discover easily the MDEP IDs and
>  data types offered by remote device.
> 
> e) The API allows for active connection, but still the application must
>  register the HDP role beforehand. This ensures that a proper SDP record
>  will have been published. (HDP sinks, the most common role a BlueZ-running
>  device will play, require the SDP record).
> 
> f) HDP would be implemented inside bluetoothd as a plugin.
> 
> g) HDP itself does not specify the data channels' protocol (it is normally
>  the IEEE 11073-20601, but there may be others in the future). The API
>  client would receive L2CAP sockets for each data channel, and
>  select()/recv()/send() them directly.
> 
> h) The application would be responsible by keeping the relationship between
>  MDL IDs and IEEE sessions, if it wants to enjoy the reconnection feature.
>  Also, it needs to be prepared to have a MDL socket closed, receive another
>  one and continue the session over it.
> 
> If the application does not want to deal with reconnection, it may ask for
>  MDL deletion upon socket closure, or just take the new socket as a brand
>  new MDL.
> 
> The HDP plugin would keep the necessary state information (local and remote
>  MDEP IDs) to allow easy (and transparent) reconnection.

This is more or less what we think. We believe that is better to talk it by 
IRC. By now he have a sequence diagram with the interaction of HDP with the 
clients (agents or managers).

http://193.147.51.48/hdp_sequence.png

> 
> 
> Cadenas and Nemesio have already sent patches with an initial MCAP
>  implementation, some time ago. We hope to build on their initial effort
>  and collaborate with them in order to have HDP implemented as soon as
>  possible and offering a very comfortable API for the clients.

The patches are now obsolete, because we made a lot of changes on it. We 
haven't sent it yet because we are still waiting for comments about the 
architecture proposed in last patches. It will be better to discard those 
patches. We can also comment/explain the MCAP arquitecture if we have a 
meeting. We are planning to send new patches with all the changes next week. 

> 

Regards

Jose and Santiago

PS: Also CCing Pedro de-las-Heras who is also working with us.

> --
> Elvis
> 
