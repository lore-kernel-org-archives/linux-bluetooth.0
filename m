Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Health Device Profile API
From: Santiago Carot-Nemesio <scarot@libresoft.es>
To: Elvis =?ISO-8859-1?Q?Pf=FCtzenreuter?= <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1272928958-8073-1-git-send-email-epx@signove.com>
References: <1272928958-8073-1-git-send-email-epx@signove.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 04 May 2010 09:50:05 +0200
Message-ID: <1272959405.2182.117.camel@mosquito>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Elvis,

We think that we are doing the same work in HDP. We are working in the
API for that pugin since last months but we prefer finish MCAP
implementation before fixing HDP API.

We saw your latest patches and next there are our comments. It seems a
lot with our first prototype implementation.
There are some functionalities that we like but we miss other else. We
are going to send an e-mail with the API that we propose.
We expect that we can work together to get a HDP API early. Remember
that we can talk in #openhealth if you want, just tell us when you can
attend ;)

El lun, 03-05-2010 a las 20:22 -0300, Elvis Pfützenreuter escribió:
> From: Elvis Pfutzenreuter <epx@signove.com>
> 
> Initial Health API proposal. Includes Adapter, Device and HealthAgent API
> description. Proposed API can address Health source and sink roles.
> 
> Adapter methods exported on Health interface allow HealthAgent
> registration. Device methods exported on Health interface allow
> applications to actively created MCAP data channels and get informations
> of the services exported by the endpoints.
> 
> HealthAgent allows applications to receive multiple data streams encoded
> on IEEE 11073-20601 Personal Health Data Exchange Protocol.
> 
> v2 changes: added HealthData connection object interface
> 	    assumes at most one HDP set of roles per application
> ---
>  doc/health-api.txt |  187 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 187 insertions(+), 0 deletions(-)
>  create mode 100644 doc/health-api.txt
> 
> diff --git a/doc/health-api.txt b/doc/health-api.txt
> new file mode 100644
> index 0000000..49c043d
> --- /dev/null
> +++ b/doc/health-api.txt
> @@ -0,0 +1,187 @@
> +BlueZ D-Bus Health API description
> +*********************************
> +
> +Copyright (C) 2010 Elvis Pfutzenreuter <epx@signove.com>
> +
> +Health Adapter hierarchy
> +========================
> +
> +Service		org.bluez
> +Interface	org.bluez.Health
> +Object path	[variable prefix]/{hci0,hci1,...}
> +
> +This object hierarchy intend to be used by applications which want to enable
> +a Health source or sink end point. The most common usage scenario is the sink
> +role. Multi-channel protocol internals are hidden from the application interface.
> +
> +Methods:
> +	void RegisterRole(dict options, object path)
> +
> +		Register an HDP role to the adapter and assign the health agent
> +		that shall be responsible by address data channel connections.
> +
> +		Records and channels are automatically closed when the agent
> +		leaves the bus. Mandatory and optional options are described
> +		below:
> +			Optional parameters (dinamically assigned when not
> +			informed):
> +			uint16 CPSM: control channel PSM
> +			uint16 DPSM: data channel PSM
> +
> +			Mandatory parameters:
> +			array{dict EndPoint} EndPoints: Array of end points.
> +				Possible EndPoint properties:
> +				uint8 MDEPId: Mandatory MCAP Data End Point
> +					Identification
> +				uint16 DataType: Mandatory Endpoint data type
> +				string Role: "source" or "sink"
> +				string Description: Optional description
> +
> +	UnregisterRole()
> +
> +		Removes an HDP role and kills all connections related to it.
> +

We believe that it is better that applications doesn't need to provide
parameters that can be managed internally by HDP plugin such as MDEPs.
Then applications could get an avaible MDEP provided by HDP instead of
provide it. This way HDP doesn't have to check that the mdep provided is
a valid mdep and that mdep is not registered two times with different
roles.
We have provided an abstraction based in HDP sessions becasue there may
exist different HDP sessions running in the same host. Your API doesn't
seem to take in count that possibility.

> +
> +Health Agent hierarchy
> +======================
> +
> +Service		unique name
> +Interface	org.bluez.HealthAgent
> +Object path	freely definable
> +
> +Agent responsible by address data channels connections. Either active or
> +passive connections are notified. FD passing mechanism is used to allows
> +the HealthAgent to access directly the data encoded on IEEE 11073-20601
> +Personal Health Data Exchange Protocol.
> +
> +Methods:
> +	void NewDataConnection(dict properties)
> +
> +		This method gets called when a new data channel connection
> +		is established. It addresses host and remote initiated
> +		connections.
> +
> +		Properties:
> +			string device_path: the Health Device object path
> +			string connection_path: the HealthData object path
> +			boolean Passive: Device initiated connection
> +			boolean Reconnection: Previous established data
> +				channel reestablished
> +
> +	void Release()
> +
> +		This method gets called whenever the service daemon unregisters
> +		the agent or whenever the Adapter where the HealthAgent
> +		registers itself is removed.
> +
> +

Above callbacks reflect same ideas that we have, but we propose a
session oriented agent (we call HdpAgent in the e-mail) that
applications should provide when they connect to a HdpSession. Once
applications are connected to a session, HDP will notify them using that
d-bus object.

> +Health Device hierarchy
> +=======================
> +
> +Service		org.bluez
> +Interface	org.bluez.Health
> +Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
> +
> +The methods described below can be used by applications that need
> +to manage data channel connections or get properties of service
> +exported by the remote device.
> +
You can't rely in remote HDP record for Source devices (it is not
mandatory for them to registry it).  we dont understand why you need to
provide a local mdep for the connection of the data channel, only the
remote mdep is required for do that.

> +Methods:
> +
> +	string Connect(dict parameters)
> +
> +		Method used by applications that need to actively create
> +		a data channel connection. When the remote connects back
> +		in the data channel PSM, the connection is reported to
> +		the registered HealthAgent.
> +
> +		Returns an HDP Connection object path. The same path
> +		will be received again via Agent, when connection is
> +		established.
> +
> +		If the reconnection is not possible, a new connection
> +		will be created (automatic fallback). The MDL ID may
> +		change; the application needs to check HealthData object
> +		MDLId property when connection is notified via Agent.
> +
> +		Mandatory parameters:
> +			uint8 local_mdepid: local MDEP ID (*)
> +			uint8 remote_mdepid: remote MDEP ID
> +		Optional parameters:
> +			uint16 mdlid: MDL ID, if trying reconnection

Reconnections may be transparent for applications, we believe that HDP
knows when a data channels is re-connected. (see our API for more
details)

> +
> +		(*) Was defined by application when it called RegisterRole().
> +
> +	dict GetProperties()
> +
> +		Returns the device properties.
> +
> +Signals:
> +
> +	PropertiesChanged()

We think that it is unnecessary because properties should not change
when a HDP session is running.

> +
> +Properties:
> +		array{MDEPs}: array of remote data end points. Attributes of
> +			a MDEP entry are:
> +				uint8 MDEPId
> +				uint16 DataType
> +				string Role: "source" or "sink"
> +				string Description: optional description

We like this. we think that it is helpful for to get remote information
from a remote device.

> +
> +		array{MDLs}: array of open data channels. Mandatory
> +			MDLs attributes are:
> +			uint16 MDLId: Data channel identification
> +			string path: HealthData object path

I think that above method is not necessary because an HdpAgent always is
notified when a new data channel is created or destroyed, but we are
open to discuss.

> +
> +		boolean Connected: true when the MCAP control channel is
> +					established
> +
> +
> +Health Device Data Connection hierarchy
> +=======================================
> +
> +Service		org.bluez
> +Interface	org.bluez.HealthData
> +Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/YYYYYYYYYYY
> +
> +A HealthData object can be created either by active connection of by
> +receiving a connection via HealthAgent.
> +
> +FD passing concept is used to allow applications to handle data channels.
> +
> +A HealthData object exists only while the data connection is up. If the
> +connection is broken, the object is removed. The application may
> +(and should) handle this situation, by trying a reconnection.
> +If the connection was not deleted, the MDL ID outlives the respective
> +HealthData object. (Another sign of connection breakage is file
> +descriptor closure.)
> +
We believe that connections and reconnections should be transparents to
application, for example, if data channel is closed, next time that an
application want to get the data channel fd to send data, HDP could
re-connected the previously closed data channel.
We have done that because under some conditions, devices can close an
MCL for power saving and upper application shouldn't be affected (you
can see 11073-20601 state machine for more details or HDP white paper)

> +The methods described below can be used by applications to manage
> +a single data channel or get its properties.
> +
> +Methods:
> +
> +	filedescriptor GetFD()
> +
> +		Obtains the raw filedescriptor for this data channel
> +		(most likely a L2CAP socket.)
> +
> +	void Disconnect()
> +
> +		Closes this data channel and destroys the object,
> +		but keeps the MDL ID valid for future reconnections.
> +
> +	void DeleteConnection()
> +
> +		Closes this data channel, destroys the object
> +		 and invalidates the MDL ID.

This is more or less that we have thought, but taking in count that
there may exist more Hdp session running on the same host.
> +
> +	dict GetProperties()
> +
> +		Returns the device properties.
> +
> +Properties:
> +		uint8 LocalMDEPId: Local data channel identification
> +		uint8 RemoteMDEPId: Remote data channel identification
> +		uint16 MDLId: data channel ID
> +		uint16 MTU: L2CAP channel message MTU

Regards.
Jose and Santiago


