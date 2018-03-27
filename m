Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: Re: [PATCH v3] Mesh: add 'node-reset' command
Reply-To: a.rai@samsung.com
From: Atul Kumar Rai <a.rai@samsung.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC: Anupam Roy <anupam.r@samsung.com>,
        SACHIN DEV SHARMA <sachin.dev@samsung.com>
In-Reply-To: <1521558707.3681.6.camel@intel.com>
Message-ID: <20180327131932epcms5p319b3d9a169914cf4c632970b0637fad1@epcms5p3>
Date: Tue, 27 Mar 2018 18:49:32 +0530
Content-Type: text/plain; charset="utf-8"
References: <1521558707.3681.6.camel@intel.com>
        <1521445336-15582-1-git-send-email-a.rai@samsung.com>
        <CGME20180319074231epcas2p40d1a1ce4df102b678bf18c95af49a4c4@epcms5p3>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ping.

>=C2=A0Hi=C2=A0Atul,=0D=0A>=0D=0A>=C2=A0On=C2=A0Mon,=C2=A02018-03-19=C2=A0a=
t=C2=A013:12=C2=A0+0530,=C2=A0Atul=C2=A0Rai=C2=A0wrote:=0D=0A>>=C2=A0This=
=C2=A0patch=C2=A0adds=C2=A0'node-reset'=C2=A0command=C2=A0which=C2=A0can=C2=
=A0be=C2=A0used=C2=A0to=C2=A0reset=C2=A0a=0D=0A>>=C2=A0node=C2=A0(other=C2=
=A0than=C2=A0a=C2=A0Provisioner)=C2=A0and=C2=A0remove=C2=A0it=C2=A0from=C2=
=A0the=C2=A0network.=0D=0A>>=C2=A0---=0D=0A>>=C2=A0=C2=A0mesh/config-client=
.c=C2=A0=7C=C2=A018=C2=A0++++++++++++++++++=0D=0A>>=C2=A0=C2=A01=C2=A0file=
=C2=A0changed,=C2=A018=C2=A0insertions(+)=0D=0A>>=C2=A0=0D=0A>>=C2=A0diff=
=C2=A0--git=C2=A0a/mesh/config-client.c=C2=A0b/mesh/config-client.c=0D=0A>>=
=C2=A0index=C2=A019e617d..a6cd87e=C2=A0100644=0D=0A>>=C2=A0---=C2=A0a/mesh/=
config-client.c=0D=0A>>=C2=A0+++=C2=A0b/mesh/config-client.c=0D=0A>>=C2=A0=
=40=40=C2=A0-342,6=C2=A0+342,17=C2=A0=40=40=C2=A0static=C2=A0bool=C2=A0clie=
nt_msg_recvd(uint16_t=C2=A0src,=0D=0A>>=C2=A0uint8_t=C2=A0*data,=0D=0A>>=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bt_shell_printf(=22Min=C2=A0Hops=5Ct%2.2x=5Cn=
=22,=C2=A0data=5B7=5D);=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bt_shell_=
printf(=22Max=C2=A0Hops=5Ct%2.2x=5Cn=22,=C2=A0data=5B8=5D);=0D=0A>>=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0break;=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*=C2=A0Per=C2=A0Mesh=C2=A0Profile=C2=
=A04.3.2.54=C2=A0*/=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0case=C2=A0OP_NODE_RESET_STATUS:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0bt_shell_printf(=22Node=C2=A0%4.4x=C2=A0reset=C2=A0status=C2=A0%s=5Cn=22=
,=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0src,=C2=A0mesh_=
status_str(data=5B0=5D));=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0net_release_address(node_get_primary(node),=0D=0A>>=C2=A0+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(node_get_num_elements(node)));=0D=0A>>=C2=A0=
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0/*=C2=A0TODO:=C2=A0Remove=C2=A0node=C2=A0info=C2=A0=
from=C2=A0database=C2=A0*/=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0node_free(no=
de);=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;=0D=0A>>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7D=0D=0A>>=C2=A0=C2=A0=0D=0A>>=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=C2=A0tru=
e;=0D=0A>>=C2=A0=40=40=C2=A0-1124,6=C2=A0+1135,11=C2=A0=40=40=C2=A0static=
=C2=A0void=C2=A0cmd_ttl_get(int=C2=A0argc,=C2=A0char=0D=0A>>=C2=A0*argv=5B=
=5D)=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cmd=
_default(OP_CONFIG_DEFAULT_TTL_GET);=0D=0A>>=C2=A0=C2=A0=7D=0D=0A>>=C2=A0=
=C2=A0=0D=0A>>=C2=A0+static=C2=A0void=C2=A0cmd_node_reset(int=C2=A0argc,=C2=
=A0char=C2=A0*argv=5B=5D)=0D=0A>>=C2=A0+=7B=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cmd_default(OP_NODE_RESET);=0D=0A>>=C2=A0+=
=7D=0D=0A>>=C2=A0+=0D=0A>>=C2=A0=C2=A0static=C2=A0const=C2=A0struct=C2=A0bt=
_shell_menu=C2=A0cfg_menu=C2=A0=3D=C2=A0=7B=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.name=C2=A0=3D=C2=A0=22config=22,=0D=0A=
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.desc=C2=A0=
=3D=C2=A0=22Configuration=C2=A0Model=C2=A0Submenu=22,=0D=0A>>=C2=A0=40=40=
=C2=A0-1179,6=C2=A0+1195,8=C2=A0=40=40=C2=A0static=C2=A0const=C2=A0struct=
=C2=A0bt_shell_menu=C2=A0cfg_menu=C2=A0=3D=C2=A0=7B=0D=0A>>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cmd_sub_add,=C2=A0=C2=A0=C2=A0=C2=A0=
=22Add=C2=A0subscription=22=7D,=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=7B=22sub-get=22,=C2=A0=22<ele_addr>=C2=A0<model=C2=
=A0id>=22,=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cmd=
_sub_get,=C2=A0=C2=A0=C2=A0=C2=A0=22Get=C2=A0subscription=22=7D,=0D=0A>>=C2=
=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7B=22node-reset=22,=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0NULL,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cmd_n=
=0D=0A>>=C2=A0ode_reset,=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=22Reset=C2=A0a=C2=A0node=C2=A0and=C2=A0remove=C2=A0it=C2=A0from=0D=
=0A>>=C2=A0network=22=7D,=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=7B=7D=C2=A0=7D,=0D=0A>>=C2=A0=C2=A0=7D;=0D=0A>>=C2=A0=C2=
=A0=0D=0A>=C2=A0This=C2=A0looks=C2=A0fine.=0D=0A>=C2=A0Thanks,=0D=0A>=C2=A0=
Inga
