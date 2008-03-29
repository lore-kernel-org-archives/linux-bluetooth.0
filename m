Return-Path: <cyrus@holtmann.org>
From: David Stockwell <dstockwell@frequency-one.com>
To: bluez-devel@lists.sourceforge.net
Date: Sat, 29 Mar 2008 08:30:16 -0500
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_oRk7HAoh5AgkLcy"
Message-Id: <200803290830.16736.dstockwell@frequency-one.com>
Subject: [Bluez-devel] Proposed API for org.bluez.audio.control (AVRCP)
Reply-To: dstockwell@frequency-one.com,
	BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--Boundary-00=_oRk7HAoh5AgkLcy
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Marcel, Johan, Brad, et al:

As promised, I have laid out a first draft interface for .control, which is 
largely based on AVRCP support provided by CSR.

It appears that the *-api.txt documents are created with groff (or something 
like that); this document I just quickly hacked together in KWrite (similar 
to MS Notepad).

Any and all comments will be appreciated.

-- 
David Stockwell
Frequency One

--Boundary-00=_oRk7HAoh5AgkLcy
Content-Type: text/plain;
  charset="us-ascii";
  name="avrcp-api.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="avrcp-api.txt"

org.bluez.audio.Control interface

This interface is available for remote devices which implement support for an
AVRCP controller and target.

Object path(s)	/org/bluez/audio/device*

Methods:
	void	Connect(uint8 role)
		Request connection between this node and remote device.
		Role is role of THIS node in the connection, {CT|TG|CT&TG}.

	void	Disconnect()
		Disconnect from the remote device.

	boolean IsConnected()
		Returns TRUE if connected with the remote device.

	boolean GetUnitInfo()
		Sends UnitInfo command to target of connection

	boolean SendUnitInfo(boolean accepted,
			uint8 avc_subunit_type, uint16 unit, uint32 company_id)
		Called to send UnitInfo (in response to a UnitInfoRequested signal).
		NOTE:	Once this is set, should it be possible to auto-respond to
			future UnitInfoRequested signals?

	boolean GetSubUnitInfo(uint8 page)
		Sends UnitInfo command to target of connection

	boolean SendSubUnitInfo(boolean accepted, uint8 page,
			const uint8 * page_data)
		Called to send a page of SubUnitInfo (in response to a
		SubUnitInfoRequested signal).

	boolean SendPassthrough(uint8 avc_subunit_type,
			uint8 avc_subunit_id, boolean state, avc_operation_id key,
			uint16 sizeof_op_data, const uint8 * op_data)
		Called to send Passthrough commands.

	boolean SendVendorDependent(uint8 avc_subunit_type,
			uint8 avc_subunit_id, uint8 ctype, uint32 company_id,
			uint16 sizeof_op_data, const uint8 * op_data)
		Called to send VendorDependent commands (also used internally for
		Metadata).

	void	SendMetadata(uint8 avc_subunit_type,
			uint8 avc_subunit_id, uint8 ctype,
			{uint16 meta_attr, const char * meta_element})
		Called to send Metadata commands (a subset of the
		VendorDependent message). May be multiple meta attribute/element pairs.

Signals:
	void	Connected()
		Sent when a successful connection has been made to the remote device.

	void	Disconnected()
		Sent when a connection to the remote device has been disconnected.

	void	ConnectRequested(string address, uint8 role)
		Sent when a remote device wishes to connect.

	void	DisconnectRequested()
		Sent when a connected remote device wishes to disconnect.

	void	UnitInfoRequested()
		Received when another connected device requests UnitInfo.

	void	UnitInfoReceived(boolean accepted,
			uint8 avc_subunit_type, uint16 unit, uint32 company_id)
		Called when response to GetUnitInfo is received from connected
		device.

	void	SubUnitInfoRequested(uint8 page)
		Received when another connected device requests SubUnitInfo

	void	SubUnitInfoReceived(boolean accepted, uint8 page,
			const uint8 * page_data)
		Called when response to GetSubUnitInfo is received from connected device.

	void	PassthroughReceived(uint8 avc_subunit_type,
			uint8 avc_subunit_id, boolean state, avc_operation_id key,
			uint16 sizeof_op_data, const uint8 * op_data)
		Called when Passthrough command is received from connected device.

	void	VendorDependentReceived(uint8 avc_subunit_type,
			uint8 avc_subunit_id, uint8 ctype, uint32 company_id,
			uint16 sizeof_op_data, const uint8 * op_data)
		Called when VendorDependent message is received from connected device
		(except for Metadata).

	void	MetadataReceived(uint8 avc_subunit_type,
			uint8 avc_subunit_id, uint8 ctype,
			{uint16 meta_attr, const char * meta_element})
		Called when Metadata is received from connected device.  May be multiple
		meta attribute/element pairs.

--Boundary-00=_oRk7HAoh5AgkLcy
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--Boundary-00=_oRk7HAoh5AgkLcy
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_oRk7HAoh5AgkLcy--
