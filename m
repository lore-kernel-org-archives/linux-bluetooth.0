Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
Content-Type: text/plain; charset=us-ascii
Subject: More about proposed Health Device Profile API
Date: Thu, 29 Apr 2010 23:28:45 -0300
Message-Id: <8FDD2957-B97E-4646-B164-4B00E7910399@signove.com>
Cc: claudio.takahasi@openbossa.org,
	Jose Antonio Santos Cadenas <santoscadenas@gmail.com>,
	Santiago Carot Nemesio <sancane@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	raul.herbster@signove.com
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Apple Message framework v1078)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A very simple session graph that illustrates the proposed API can be seen at http://epx.com.br/health_bluez.png.

This API proposal was discussed jointly with Claudio Takahashi, Vinicius Gomes, Raul Herbster and others, and it is based on previous work on MCAP API specification by Jose Cadenas and Santiago Nemesio, which have been CCed.

The main guidelines of our current proposal are:

a) MCAP is just a protocol, which does not specify SDP records for its own needs. The HDP profile specifies the necessary SDP record, so we expose an API for HDP, not for MCAP.

b) Avoid exposing MCAP protocol details to the API client, except where unavoidable. Several MCAP parameters like PSM control channel may be left undefined by the client, and the implementation would fill them with reasonable values.

c) MCAP control connection (MCL) is completely taken care of. The application only deals with MCAP data channels (MDLs), if any.

d) The application should not need to handle SDP records, which are quite complicated in the HDP case. When it registers a HDP role, enough information is passed so a SDP record may be published automatically.

When a remote HDP device is present, its SDP record would be interpreted automatically, so the application can discover easily the MDEP IDs and data types offered by remote device.

e) The API allows for active connection, but still the application must register the HDP role beforehand. This ensures that a proper SDP record will have been published. (HDP sinks, the most common role a BlueZ-running device will play, require the SDP record).

f) HDP would be implemented inside bluetoothd as a plugin.

g) HDP itself does not specify the data channels' protocol (it is normally the IEEE 11073-20601, but there may be others in the future). The API client would receive L2CAP sockets for each data channel, and select()/recv()/send() them directly.

h) The application would be responsible by keeping the relationship between MDL IDs and IEEE sessions, if it wants to enjoy the reconnection feature. Also, it needs to be prepared to have a MDL socket closed, receive another one and continue the session over it.

If the application does not want to deal with reconnection, it may ask for MDL deletion upon socket closure, or just take the new socket as a brand new MDL.

The HDP plugin would keep the necessary state information (local and remote MDEP IDs) to allow easy (and transparent) reconnection.


Cadenas and Nemesio have already sent patches with an initial MCAP implementation, some time ago. We hope to build on their initial effort and collaborate with them in order to have HDP implemented as soon as possible and offering a very comfortable API for the clients.

--
Elvis